# -*- coding: utf-8 -*-
import arcpy
import os, sys
import json
import psycopg2
from unidecode import unidecode
from log_class import Log

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

def main():
    try:
        global arqlog
        # abre o arquivo de log
        arqlog = Log()
        arqlog.abrir()
        arqlog.gera("### CARGA DE DADOS ARGIS > PGSQL INICIADA! ###")

        arqlog.gera("Carregando as configurações da aplicação...")
        config = getAppConfig()

        arqlog.gera("Efetuando conexão com o servidor PGSQL...")
        pgsql_conn = getPGSQLConnection(config)

        arqlog.gera("Criando esquemas no banco PGSQL, caso não existam...")
        createPGSQLSchemas(config["pg_database"]['schemas'], pgsql_conn)

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

            arqlog.gera("Criando camada e tabelas relacionadas...")
            createPGSQLTable(json_data['pgsql_table'], pgsql_conn)
            

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