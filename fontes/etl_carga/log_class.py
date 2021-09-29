# -*- coding: utf-8 -*-
import datetime

class Log:
    def __init__(self):
        agora = datetime.datetime.today()
        formato = "%Y%m%d_%H%M%S"
        self.nome = "logs\\log_" + agora.strftime(formato) + ".log"
        self.oFile = None

    # abre o arquivo de log
    def abrir(self):
        self.oFile = open(self.nome, 'w')

    # fecha o arquivo de log
    def fechar(self):
        self.oFile.close()
        self.oFile = None

    # insere o texto de <mensagem> no arquivo de log
    def gera(self, mensagem):
        agora = datetime.datetime.today()
        formato = "%Y-%m-%d %H:%M:%S: "
        self.oFile.write(agora.strftime(formato) + mensagem + "\n")
        print(agora.strftime(formato) + mensagem)