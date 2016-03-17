
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [1 How to Run iVantage](#1-how-to-run-ivantage)
  - [1.1 Prepare database](#11-prepare-database)
  - [1.2 Install ruby/rails environment](#12-install-rubyrails-environment)
    - [1.2.1 Install RVM](#121-install-rvm)
    - [1.2.2 Use RVM to install Ruby environment](#122-use-rvm-to-install-ruby-environment)
    - [1.2.3 Set Ruby version](#123-set-ruby-version)
    - [1.2.4 Install rails](#124-install-rails)
  - [1.3 Start database](#13-start-database)
    - [1.3.1 run the database](#131-run-the-database)
    - [1.3.2 generate the table structure](#132-generate-the-table-structure)
    - [1.3.3 import data](#133-import-data)
  - [1.4 Run Application](#14-run-application)
    - [1.4.1 Run](#141-run)
    - [1.4.2 Setup](#142-setup)
    - [1.4.3 Act I](#143-act-i)
     - [1.4.4 Act II](#144-act-ii)
     - [1.4.5 Act III](#144-act-iii)
- [2. Page Display Introduce](#2-page-display-introduce)
- [3. Features](#3-features)
- [4. Technologies](#4-technologies)
- [5. Process Analysis](#5-process)
  - [5.1 how does "Update Map" button on 1L2L work?](#51-how-does-update-map-button-on-1l2l-work)
  - [5.1 how does "Next" button on 2R work?](#51-how-does-next-button-on-2r-work)
- [6. Reference](#6-reference)



<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## 1 How to Run iVantage
    
### 1.1 Install psql

check whether psql has been installed using following command:

```
$ psql --version
```

if you can get the version of psql by this command, it shows that psql has been installed successfully, if not, use homebrew to install psql:

```
$ brew install postgesql -v
``` 

Besides, you can install [pgadmin](http://www.postgresql.org/ftp/pgadmin3/release/v1.20.0/osx/) by here.

### 1.2 Configure ruby/rails environment

#### 1.2.1 Install RVM

use the following command to install rvm:

```
$ curl -L https://get.rvm.io | bash -s stable
```
then, load the RVM environment

```
$ source ~/.rvm/scripts/rvm
```
check whether the installation above is right:

```
$ rvm -v
```

#### 1.2.2 Use RVM to install Ruby environment

list the known ruby version:

```
$ rvm list known
```
you can select rvm version to install(use install rvm 2.0.0 as an example)

```
$ rvm install 2.0.0
```

#### 1.2.3 Set Ruby version

after installing RVM, use command to set a ruby version as the default version

```
$ rvm 2.0.0 --default
```
then you can test whether the ruby and gem have been installed successfully

```
$ ruby -v && gem -v
```

#### 1.2.4 Install rails

use `rails --version` to check whether the rails has been installed, if not, use the following command to install rails:

```
$ sudo gem install rails
```

### 1.3 Configure database

#### 1.3.1 start the database

use the following command to run the postgresql database:

```
$ pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
```


#### 1.3.2 Restore database

- Create new role named hdwall
- Create new database named hd_wall_dev
- Execute `bundle exec rake db:migrate` to generate the database structure

#### 1.3.3 import data


Make sure you can access the backup database file [hd_wall_dev](https://drive.google.com/a/pwc.com/folderview?id=0B2ul8xX7LkvtcWtZRm1waHNRR1E&usp=sharing), then:

- Right-click the database ‘hd_wall_dev’, then choose ‘Restore’
- Localize the backup file on filed ‘Filename’
- Switch to ‘Restore Options #2’ then check ‘Clean before restore’ on section ‘Queries’
- Click ‘Restore’ to import data, then click ‘Done’ to finish it if no error occurs.


### 1.4 Run Application


#### 1.4.1 Run

run the application using the following command:

```
$ bundle exec rails s
```

run the application by visit this address: 
http://0.0.0.0:3000/

#### 1.4.2 Setup
- Open the homepage in Chrome in the left 2 panels
- Open the homepage in Firefox somewhere in the right 6 panels
    
### 1.4.3 Act I
- In Chrome, click the 1L2L button (it should pop up to fill the left 2 panels)
- In Firefox, click the 1R button

### 1.4.4 Act II
- Close 1R
- In Chrome, scroll down in 1L2L, and click the "Act II" button
    
### 1.4.5 Act III

- Close 2MT1, 2MT2, 2MB, 2R
- In Chrome, click the 3L button
- In Firefox, click the 3R button
- Zoom into 3R until the white space underneath the maps is gone


## 2. Page Display Introduce


This app is intended to be displayed on a very large wall. We displayed on 8 55" HD monitors stacked 4 wide x 2 tall, for an active screen area of about 16' wide x 4.5' tall. 

The app is divided into 3 separate layouts (depicted below). Each layout has separate screens (labeled below). 

    Layout 1:                   Layout 2:                   Layout 3:
     ___________________     _____________________      _____________________
    |1L2L|     1R       |    |1L2L| 2MT|2MT | 2R |      | 3L |      3R      |
    |    |              |    |    |____|____|    |      |    |              |
    |    |              |    |    |   2MB   |    |      |    |              |
    |____|______________|    |____|_________|____|      |____|______________|



## 3 Features 

- Big Maps (1R, 3R) require Firefox (it craps out in Chrome)
- 1L2L requires Chrome (the pie chart craps out in Firefox)
- 3R requires zoom to remove white space below the map
- The more Firefox is zoomed in, the larger the 3R popup will be. I suggest keeping it at the appropriate zoom so that the popup is sized properly, then zoom into 3R after it's open



## 4 Technologies

 - jQuery Mobile and Theme Roller
 
    To get it to work, be sure to not only 'bundle install', but also 'bundle install --path vendor' 
 - Google Maps API (v3) and Google Earth API
 
    In order to use it, you'll need to use an API key. See this site for more info: 
    https://developers.google.com/maps/documentation/javascript/tutorial 
 - WebSockets 
 
    Used for intra-screen communication. For example, clicking on 1L2L sends messages via WebSockets to 1R and 2MT
 - AJAX
 
    Used to update the page with database content without refreshing the entire page. For example, whenever a new cluster is built, 2R makes a database call and adds the new content to itself. 
 - Amplify.js
 
    Used to simplify WebSocket and AJAX commands. 


## 5. Process Analysis

### 5.1 how does "Update Map" button on 1L2L work? 

 1) 1L2L.html   
 
 - click the "Update Map" button
 - controlPanelValues() function is called
 
 2) 1L2L.js     
 
 - controlPanelValues() function is executed
 - 5 URL parameters are built (one for each variable Category, and one for the Filters)
 - WebSocket message is sent
 
 3) 1R.html 
 
 - updateMapKML is defined, so that screen 1R will handle the incoming WebSocket message
 
 4) 1R.js   
 
 - updateMapKML is executed
 - drawLayer() function is called, using parameters
 
 5) 1R.html     
 
 - drawLayer() function is executed, using parameters



### 5.1 how does "Next" button on 2R work? 


 1) 2R.html     
 
 - click the "Next" button
 - sendClusters() function is called
 
 2) 2R.js       
 
 - sendClusters() function is executed
 - WebSocket message is sent ("createClusterTabs")
 
 3) 3L.html     
 
 - createClusterTabs is defined, so that screen 3L will handle the incoming WebSocket message
 
 4) 3L.js       
 
 - createClusterTabs() is executed
 
 5) 3L.html     
 
 - new cluster tab is added, and its tab contents are added
 - update3Lgroupbar() function is called
                

### 6. Reference

- [How to Run on the Wall: iVantage](https://docs.google.com/document/d/17tUvrgvO4KyGowFfHX-Zbd1qVb6ey3T4OkpeAiY0DFc/edit)
