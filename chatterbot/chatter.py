#!/usr/bin/python
#coding=utf-8
import time
from chatterbot import ChatBot
#from chatterbot.trainers import ListTrainer
import sys
reload(sys)
bot = ChatBot(
    "Norman",
    #storage_adapter = 'chatterbot.storage.MongoDatabaseAdapter',database_uri = 'mongodb：//example.com：8100 /'database = 'chatterbot-database'
    storage_adapter= {'import_path':'chatterbot.storage.MongoDatabaseAdapter','database_name':'chatterbot-database','database_uri':'mongodb://172.19.7.109:27017/'},
#    input_adapter="chatterbot.input.TerminalAdapter",
    input_adapter="chatterbot.input.VariableInputTypeAdapter",
    output_adapter="chatterbot.output.OutputAdapter",
    output_format = "text",
   # output_adapter="chatterbot.output.TerminalAdapter",
    logic_adapters = [
        "chatterbot.logic.MathematicalEvaluation",
        "chatterbot.logic.TimeLogicAdapter",
        "chatterbot.logic.BestMatch",
    ],
    )
'''
conversation = [
"你是一个程序员吗?",
"我是个程序员",
"你使用什么语言呢?",
"我经常使用 Python, Java 和 C++ .",
"我常使用 Python.",
"我不怎么喜欢 Java.",
"什么使你心烦?",
"它有许多不一致的地方"
]

bot.set_trainer(ListTrainer)
bot.train(conversation)
'''
sys.setdefaultencoding('utf-8')
statment = sys.argv[1]
print bot.get_response(statment)
'''
while True:
    try:
        text = input('和hobo聊天：')
        bot_input = bot.get_response(text)
        time.sleep( 5 )
        print(bot_input)
    except(KeyboardInterrupt, EOFError, SystemExit):
        break
'''
