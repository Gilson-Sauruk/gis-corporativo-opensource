# -*- coding: utf-8 -*-
import arcpy
import os, sys
import json
import psycopg2
import pyodbc
from unidecode import unidecode
from log_class import Log

def LoadParameters(args):
    try:
        dict_ret = {}
        valid_pars = ["rebuildsde", "help", "jsonfile", "dontcreateschema", "jsonprefix"]
        if len(args) > 1:
            del args[0]
            s_args = u" ".join(args)
            s_args = s_args.replace("--","-")
            l_args = s_args.split("-")
            l_args.remove('')

            if len(l_args) > 0:
                for arg in l_args:
                    b_found = False
                    par = ""
                    for par in valid_pars:
                        if arg.find(par) >= 0:
                            arg_val = arg.replace(par, "")
                            arg_val = arg_val.strip()
                            dict_ret[par] = arg_val
                            b_found = True

                    if not b_found:
                        dict_ret["ERR"] = "Parâmetro inválido: " + par

        return dict_ret

    except:
        raise

def getAppConfig():
    try:
        with open('config.json') as config_file_data:
                config = json.load(config_file_data)

        return config
    except:
        raise

def getJSONFiles(json_prefix):
    try:
        script_folder = os.path.dirname(os.path.realpath(__file__))
        jsonfiles_folder = script_folder + "/maps"
        jsonfiles_list = []
        for root, dirs, files in os.walk(jsonfiles_folder):
            for filename in files:
                if filename.lower().endswith('.json'):
                    if json_prefix is None:
                        jsonfiles_list.append(filename)
                    else:
                        if filename.lower().startswith(json_prefix):
                            jsonfiles_list.append(filename)

        return jsonfiles_list

    except:
        raise

def getPGSQLConnection(config):
    try:
        pg_conn = psycopg2.connect(host=config['pg_database']['host'], 
                                database=config['pg_database']['database'], 
                                user=config['pg_database']['user'], 
                                password=config['pg_database']['password'])
        return pg_conn
    except:
        raise

def getSICATConnection(config):
    try:
        sicat_conn = pyodbc.connect(config["sicat_database"]["conn_string"])
        return sicat_conn
    except:
        raise

def createPGSQLSchemas(schemas, connection):
    try:
        for schema in schemas:
            schema_name = schema
            schema_user = schemas[schema]
            sql_comm = "CREATE SCHEMA IF NOT EXISTS {} AUTHORIZATION {}".format(schema_name, schema_user)
            cursor = connection.cursor()
            cursor.execute(sql_comm)
        
        connection.commit()

    except:
        raise

def createPGSQLTable(script_file, connection):
    try:
        script_folder = os.path.dirname(os.path.realpath(__file__))
        sql_file_path = script_folder + '/sql_scripts/' + script_file
        sql_file = open(sql_file_path, 'r')
        sql_commands = sql_file.read()
        cursor = connection.cursor()
        cursor.execute(sql_commands)
        connection.commit()

    except:
        raise

def progress_print(current, total):
    f_current = float(current)
    f_total = float(total)
    percent = (f_current / f_total) * 100
    int_percent = int(percent)
    str_percent = str(current) + "/" + str(total) + "(" + str(int_percent) + ") %"
    sys.stdout.write(str_percent)
    sys.stdout.flush()
    n = len(str_percent)
    sys.stdout.write((b'\x08' * n).decode())

def create_sde_connections(config):
    try:
        script_folder = os.path.dirname(os.path.realpath(__file__))
        servidor = config['arcgis_databases']['servidor']
        service = config['arcgis_databases']['service']
        core_database = config['arcgis_databases']['core_database']
        carto_database = config['arcgis_databases']['carto_database']
        usuario = config['arcgis_databases']['usuario']
        password = config['arcgis_databases']['password']

        # se o arquivo sde de conexão core existir, deleta o mesmo
        if os.path.exists(script_folder + "/gisc_core.sde"):
            arqlog.gera("Deletando o arquivo SDE de conexão CORE atual...")
            os.remove(script_folder + "/gisc_core.sde")
        
        if os.path.exists(script_folder + "/gisc_carto.sde"):
            arqlog.gera("Deletando o arquivo SDE de conexão CARTO atual...")
            os.remove(script_folder + "/gisc_carto.sde")

        # cria os arquivos de conexão SDE
        arqlog.gera("Criando um novo arquivo SDE de conexão CORE...")
        arcpy.CreateArcSDEConnectionFile_management(script_folder, "gisc_core.sde",
                                                    servidor, service, core_database,
                                                    "DATABASE_AUTH", usuario, password,
                                                    "SAVE_USERNAME", "SDE.DEFAULT", "SAVE_VERSION")
        
        arqlog.gera("Criando um novo arquivo SDE de conexão CARTO...")
        arcpy.CreateArcSDEConnectionFile_management(script_folder, "gisc_carto.sde",
                                                    servidor, service, carto_database,
                                                    "DATABASE_AUTH", usuario, password,
                                                    "SAVE_USERNAME", "SDE.DEFAULT", "SAVE_VERSION")

    except:
        raise

def getSICATNumRows(sicat_conn, json_data):
    try:
        schema = json_data["mssql_schema"]
        table = json_data["mssql_table"]
        where_clause = json_data["where_clause"]
        sql = "SELECT COUNT(*) FROM {}.{}".format(schema, table)
        if where_clause is not None:
            sql += " WHERE {}".format(where_clause)
        
        cursor = sicat_conn.cursor()
        cursor.execute(sql)
        row = cursor.fetchone()
        numrows = row[0]

        return numrows

    except:
        raise

def getSICATData(sicat_conn, json_data):
    try:
        sicat_fields = ""
        pgsql_fields = ""
        sicat_fields_list = []
        for field_row in json_data["fields"]:
            sicat_fields_list.append(field_row[0])
        
        sicat_fields = ",".join(sicat_fields_list)
        schema = json_data["mssql_schema"]
        table = json_data["mssql_table"]
        where_clause = json_data["where_clause"]
        sql = "SELECT {} FROM {}.{}".format(sicat_fields, schema, table)
        if where_clause is not None:
            sql += " WHERE {}".format(where_clause)
        
        cursor = sicat_conn.cursor()
        cursor.execute(sql)

        return cursor

    except:
        raise

def PrepareSQLInsert(json_data):
    try:
        sql = "insert into {}.{} ".format(json_data["pgsql_schema"], json_data["pgsql_table"]) 
        fields = "("
        
        for f in json_data["fields"]:
            if f[1] != 'objectid':
                fields += f[1] + ","

        fields = fields[:-1] + ")"
        sql += fields + " values ({})"

        if json_data["arcgis_attachments"]:
            sql += " returning id"

        return sql

    except:
        raise

def getSQLValuesString(row, json_data, domain_values):
    try:
        i = 0
        str_values = ""
        ret = {}
        dict_bool = {'S':'true', 'N':'false'}
        oid = None

        for value in row:
            tipo = json_data["fields"][i][2]

            if tipo == "objectid":
                oid = value
            else:
                if tipo == "geometry" and value == None:
                    str_values = None
                    ret = {
                        "result": "ERROR",
                        "message": "Geometria nula",
                        "value": None
                    }
                    break
                elif value == None:
                    str_values += "NULL,"
                else:
                    if tipo == "numeric":
                        str_values += str(value) + ","
                    elif tipo == "text":
                        str_values += "'" + unidecode(value).replace("'","''") + "',"
                    elif tipo == "date":
                        f_date = str(value.year) + "-" + str(value.month) + "-" + str(value.day)
                        str_values += "'" + f_date + "',"
                    elif tipo == "bool":
                        str_values += dict_bool[value] + ","
                    elif tipo == "domain_value":
                        domain = json_data["fields"][i][3]
                        dict_values = domain_values[domain]
                        str_values += str(dict_values[str(value)]) + ","
                    elif tipo == "geometry":
                        str_values += "ST_GeomFromText('" + value + "',31984),"

            i += 1

        if str_values is not None:
            str_values = str_values[:-1]
            ret = {
                "result": "OK",
                "message": "Ok",
                "value": str_values,
                "objectid" : oid
            }

        return ret

    except:
        raise

def LoadDomains(fields):
    try:
        domains = []
        for f in fields:
            if f[2] == 'domain_value':
                domains.append(f[3])
        
        from_to_values = None

        if len(domains) > 0:
            from_to_values = {}
            for d in domains:
                json_file = 'maps/' + d + '.json'
                with open(json_file) as content:
                    json_file_data = json.load(content)
                from_to_values[d] = json_file_data['from_to_values']

        return from_to_values

    except:
        raise

def getQueryFields(field_map):
    try:
        query_fields = []
        for f in field_map:
            query_fields.append(f[0])
        
        return query_fields

    except:
        raise

def LoadAttachments(feature_id, json_data, pgsql_cursor):
    try:
        insert_sql = "insert into {}.{}_anexos (id_{}, anexo_nome, anexo_dados) values (%s, %s, %s)".format(json_data["pgsql_schema"], 
                                                                                                json_data["pgsql_table"], 
                                                                                                json_data["pgsql_table"])
        att_table_origin = json_data['arcgis_connection_file'] + '/' + \
                                    json_data['arcgis_layer'] + "__ATTACH"
        
        where = "REL_OBJECTID = {}".format(str(feature_id))

        with arcpy.da.SearchCursor(att_table_origin, ['DATA', 'ATT_NAME', 'ATTACHMENTID'], where_clause=where) as cursor:
            for att in cursor:
                pgsql_cursor.execute(insert_sql, (feature_id, att[1], att[0]))

    except:
        raise

def main():
    try:
        global arqlog

        # checagem de parametros
        pars = LoadParameters(sys.argv)
        continua = True
        rebuild_sde = False
        p_createschema = True
        p_jason_file = None
        p_jason_prefix = None

        # abre o arquivo de log
        arqlog = Log()
        arqlog.abrir()

        if len(pars) > 0:
            if pars.has_key("help"):
                f_help = open(r'doc\help.txt', 'r')
                txt_help = f_help.read()
                print(txt_help)
                continua = False
            if pars.has_key("ERR"):
                arqlog.gera("ERRO: " + pars["ERR"])
                continua = False
            if pars.has_key("rebuildsde"):
                rebuild_sde = True
            if pars.has_key("jsonfile"):
                p_jason_file = pars["jsonfile"]
            if pars.has_key("dontcreateschema"):
                p_createschema = False
            if pars.has_key("jsonprefix"):
                p_jason_prefix = pars["jsonprefix"]

        if continua:
            
            arqlog.gera("### CARGA DE DADOS ARGIS > PGSQL INICIADA! ###")

            arqlog.gera("Carregando as configurações da aplicação...")
            config = getAppConfig()

            if rebuild_sde:
                arqlog.gera("Gerando arquivos de conexão com o geodatabase ArcGIS...")
                create_sde_connections(config)

            arqlog.gera("Efetuando conexão com o servidor PGSQL...")
            pgsql_conn = getPGSQLConnection(config)
            pgsql_cursor = pgsql_conn.cursor()

            arqlog.gera("Efetuando conexão com o servidor MSSQL do SICAT/SISCOM...")
            sicat_conn = getSICATConnection(config)

            if p_createschema:
                arqlog.gera("Criando esquemas no banco PGSQL, caso não existam...")
                createPGSQLSchemas(config["pg_database"]['schemas'], pgsql_conn)

            if p_jason_file is None:
                arqlog.gera("Recuperando os mapas JSON de carga...")
                jsonfiles = getJSONFiles(p_jason_prefix)
                arqlog.gera("{} arquivos de carga encontrados.".format(str(len(jsonfiles))))
            else:
                jsonfiles = [p_jason_file]
                arqlog.gera("Processando o arquivo de carga {}".format(p_jason_file))

            # loop over json files
            script_folder = os.path.dirname(os.path.realpath(__file__))
            jsonfiles_folder = script_folder + "/maps"

            for jsonfile in jsonfiles:
                arqlog.gera("Processando a carga mapeada em {}...".format(jsonfile))

                arqlog.gera("Carregando configurações do mapeamento...")
                with open(jsonfiles_folder + "/" + jsonfile) as jsonfiledata:
                    json_data = json.load(jsonfiledata)
                
                if json_data['type'] == 'layer': # caso o json seja de uma camada

                    arqlog.gera("Criando camada...")
                    createPGSQLTable(json_data['pgsql_create_table_script'], pgsql_conn)

                    arqlog.gera("Extraindo dados para a carga da camada {}".format(json_data['pgsql_table']))
                    feature_class = json_data['arcgis_connection_file'] + '/' + \
                                    json_data['arcgis_dataset'] + '/' + \
                                    json_data['arcgis_layer']
                    
                    arqlog.gera("Construindo comando insert padrão...")
                    insert_string = PrepareSQLInsert(json_data)

                    arqlog.gera("Identificando os campos de consulta...")
                    query_fieds = getQueryFields(json_data["fields"])

                    arqlog.gera("Carregando os domínios de valores para a camada...")
                    domains = LoadDomains(json_data["fields"])
                    
                    arqlog.gera("Recuperando o total de feições a exportar...")
                    # total_records = int(arcpy.GetCount_management(feature_class).getOutput(0))
                    rows = [row for row in arcpy.da.SearchCursor(in_table=feature_class, 
                                                field_names=query_fieds, 
                                                where_clause=json_data['where_clause'])]
                    total_records = len(rows)
                    
                    count = 1
                    bad_geometries = 0

                    arqlog.gera("Exportando um total de " + str(total_records) + " feições...")

                    for row in rows:
                        progress_print(count, total_records)
                        ret = getSQLValuesString(row, json_data, domains)

                        if ret["result"] == "OK":
                            final_insert_string = insert_string.format(ret["value"]) # completa a string de insert
                            pgsql_cursor.execute(final_insert_string)

                            if json_data["arcgis_attachments"]:
                                arqlog.gera("Carregando anexos da camada...")
                                inserted_id = pgsql_cursor.fetchone()[0]
                                LoadAttachments(inserted_id, json_data, pgsql_cursor) # <<< passar o oid como parâmetro

                            count += 1
                        else:
                            arqlog.gera("ERRO:" + ret["message"])
                            bad_geometries += 1
                    
                    arqlog.gera("Total de geometrias ruins: " + str(bad_geometries))


                elif json_data['type'] == 'sicat_table': # caso o json seja de uma tabela SICAT/SISCOM
                    
                    arqlog.gera("Criando tabela {} caso não exista...".format(json_data['pgsql_table']))
                    createPGSQLTable(json_data['pgsql_create_table_script'], pgsql_conn)

                    arqlog.gera("Calculando numero de registros a extrair...")
                    total_records = getSICATNumRows(sicat_conn, json_data)

                    arqlog.gera("Extraindo dados da tabela de origem {}...".format(json_data['mssql_table']))
                    cursor = getSICATData(sicat_conn, json_data)

                    arqlog.gera("Construindo comando insert padrão...")
                    sql_insert_original = PrepareSQLInsert(json_data)

                    arqlog.gera("Exportando um total de " + str(total_records) + " registros...")
                    count = 1
                    for row in cursor.fetchall():
                        progress_print(count, total_records)
                        sql_insert = sql_insert_original
                        ret = getSQLValuesString(row, json_data)
                        if ret["result"] == "OK":
                            sql_insert = sql_insert.format(ret["value"])
                            pgsql_cursor.execute(sql_insert)
                            count += 1
                        else:
                            arqlog.gera("ERRO:" + ret["message"])
                
                elif json_data['type'] == 'domain_values': # caso o json seja de um domínio de valores

                    arqlog.gera("Criando domínio de valores {}...".format(unidecode(json_data['name'])))
                    createPGSQLTable(json_data['pgsql_create_table_script'], pgsql_conn)
                    
                # efetua o commit da camada
                arqlog.gera("Efetuando o commit...")
                pgsql_conn.commit()
                
            sicat_conn.close()
            pgsql_conn.close()
            arqlog.gera("### CARGA CONCLUÍDA COM SUCESSO! ###")
    
    except Exception as e:
        print("ERRO NO PROCESSAMENTO:\r\n" + str(e))
        arqlog.gera("ERRO NO PROCESSAMENTO:\r\n" + str(e))
        arqlog.fechar()
        raise
    
    finally:
        del arqlog


if __name__ == '__main__':
    main()