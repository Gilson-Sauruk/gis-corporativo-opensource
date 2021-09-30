# -*- coding: utf-8 -*-
import arcpy
import os, sys
import json
import psycopg2
from unidecode import unidecode
from log_class import Log

def LoadParameters(args):
    try:
        dict_ret = {}
        valid_pars = ["rebuildsde", "help"]
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

def getJSONFiles():
    try:
        script_folder = os.path.dirname(os.path.realpath(__file__))
        jsonfiles_folder = script_folder + "/maps"
        jsonfiles_list = []
        for root, dirs, files in os.walk(jsonfiles_folder):
            for filename in files:
                if filename.lower().endswith(('.json')):
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

def createPGSQLTable(table_name, connection):
    try:
        script_folder = os.path.dirname(os.path.realpath(__file__))
        sql_file_path = script_folder + '/sql_scripts/' + table_name + '.sql'
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


def main():
    try:
        global arqlog

        # checagem de parametros
        pars = LoadParameters(sys.argv)
        continua = True
        rebuild_sde = False

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
                continua = True

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

            arqlog.gera("Criando esquemas no banco PGSQL, caso não existam...")
            #createPGSQLSchemas(config["pg_database"]['schemas'], pgsql_conn)

            arqlog.gera("Recuperando os mapas JSON de carga...")
            jsonfiles = getJSONFiles()
            arqlog.gera("{} arquivos de carga encontrados.".format(str(len(jsonfiles))))

            # loop over json files
            script_folder = os.path.dirname(os.path.realpath(__file__))
            jsonfiles_folder = script_folder + "/maps"

            for jsonfile in jsonfiles:
                arqlog.gera("Processando a carga mapeada em {}...".format(jsonfile))

                arqlog.gera("Carregando configurações do mapeamento...")
                with open(jsonfiles_folder + "/" + jsonfile) as jsonfiledata:
                    json_data = json.load(jsonfiledata)
                
                if json_data['type'] == 'layer': # caso o json seja de uma camada

                    arqlog.gera("Criando camada e tabelas relacionadas...")
                    createPGSQLTable(json_data['pgsql_table'], pgsql_conn)

                    arqlog.gera("Extraindo dados para a carga da camada {}".format(json_data['pgsql_table']))
                    feature_class = json_data['arcgis_connection_file'] + '/' + \
                                    json_data['arcgis_dataset'] + '/' + \
                                    json_data['arcgis_layer']
                    
                    total_records = int(arcpy.GetCount_management(feature_class).getOutput(0))
                    count = 1
                    bad_geometries = 0

                    arqlog.gera("Exportando um total de " + str(total_records) + " feições...")

                    insert_string = "insert into " + json_data['pgsql_schema'] + "." + \
                                    json_data['pgsql_table'] + " " + json_data['pgsql_insert_fields'] + \
                                    " values ({})"
                    
                    with arcpy.da.SearchCursor(feature_class, json_data['query_fieds']) as cursor:
                        for row in cursor:
                            progress_print(count, total_records)
                            geom_field_index = (len(row) - 1) #ultima coluna é de geometria
                            geometry_string = row[geom_field_index]

                            if geometry_string is None:
                                bad_geometries += 1
                            else:
                                values_string = ""
                                i = 0

                                for valor in row:
                                    val_string = ""

                                    if i == geom_field_index: # se for o campo de geometria
                                        val_string = "ST_GeomFromText('" + valor + "',31984)"
                                    elif valor is None: # se for um valor nulo (None)
                                        val_string = "NULL"
                                    elif type(valor) is unicode: # se for texto
                                        u_text = unidecode(valor).replace("'","")
                                        val_string = "'" + u_text + "'"
                                    elif type(valor) is datetime.datetime: # se for data
                                        f_date = str(valor.year) + "-" + str(valor.month) + "-" + str(valor.day)
                                        val_string = "'" + f_date + "'"
                                    else: # se for numerico
                                        val_string = str(valor)

                                    values_string += val_string + ","
                                    i += 1

                                values_string = values_string[:-1] # remove a última ","
                                final_insert_string = insert_string.format(values_string) # completa a string de insert
                                pgsql_cursor.execute(final_insert_string)
                                count += 1

                    # efetua o commit da camada
                    arqlog.gera("Efetuando o commit das feições na camada...")
                    arqlog.gera("Total de geometrias ruins: " + str(bad_geometries))
                    pgsql_conn.commit()


                elif json_data['type'] == 'table': # caso o json seja de uma tabela comum
                    pass
                

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