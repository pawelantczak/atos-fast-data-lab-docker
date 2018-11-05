app import --uri http://bit.ly/Darwin-SR2-stream-applications-kafka-maven
stream create --name 'time-log' --definition 'time | log'
stream deploy --name time-log

