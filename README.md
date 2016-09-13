Docker for Bitcoind
=======

### For building the bitcoind image for docker

``` docker build -t bitcoind:0.12.1 . ```

### For running a bitcoind container

* Copy the example docker-compose config file

  ```cp docker-compose.yml.example docker-compose.yml```

* Modify the configuration value, the environment variables start with 'BITCOIND_' will be transalated into bitcoind config item and save to bitcoin.conf
  
  For the single value, like 

  ``` BITCOIND_RPCUSER: haobtc ```
  
  will be translated into 
  
  ``` rpcuser=haobtc ```
  
  For the multiple values, like
  
  ``` BITCOIND_ALLOWIP: 10.0.0.1,10.0.0.2,10.0.3 ```
  
  will be translated into
  
  ``` 
  allowip=10.0.0.1
  allowip=10.0.0.2
  allowip=10.0.0.3 
  ```
  
* Run bitcoind docker image in container by using docker-compose

  ``` docker-compose up -d ```

======

inspired by [btcpool](https://github.com/btccom/btcpool)
