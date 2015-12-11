MyMQ - makes MQ application brief
=================================

This is a library to simplify an application using RabbitMQ. 
MyMQ doesn't let developers write boring convention. People can forcus on considering about message.

How to use
==========
If you want to send something data to a broker 'e1' like folloing.

![](http://userlocalhost2000.github.io/e2e_binding/img/model.png)

To publish a message, you can do it as this.
The arguments of `e1` and `r1` replesent exchange-name and routing-key, respectively.
```
MyMQ.send('message', 'e1', 'r1')
```

And Subscriber could be following.
```
MyMQ.recive('e1', 'r1') { |data| p data }
```

In addition, MyMQ implemented [e2e-binding](https://www.rabbitmq.com/e2e.html) feature. You can use this like following.
```
MyMQ.bridge('e1', 'e2', 'rkey')
```
