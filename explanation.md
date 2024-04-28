**DataBase setup**
For the db setup we will:
    -Use latest official mongo image form docker hub
    -For the db GUI we will use momgo-express to allow user to see and interact with the db, we will also use official momgo-express image from docker hub. 
    -Create a volume specific to out db named *mongo_data* for the data storage and *mongo_config* for storing db configs.
    -Create a network *mongo_net* to enable comunication for both mongo.db and mongo.express services.
    -The volumes will use local driver since we will be runing the on the local server.
    -The network will use the bridge driver which is dockers default driver.
    -The spin up should create a databese
