'use strict';

require('dotenv').config();
const express = require('express');
require('express-async-errors');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const { DbProvider } = require('./infra/data');
global.XMLHttpRequest = require('xhr2');

const app = express();

app.use(cors({ /* credentials: true */ origin: '*' }));
app.use(cookieParser());
app.use(express.json());

app.use(express.urlencoded({ extended: true }));

app.use('/categories', require('./routes/categories'));
app.use('/companies', require('./routes/companies'));
app.use('/products', require('./routes/products'));
app.use('/users', require('./routes/users'));

app.get('/test/', (req, res) => {
  res.status(200).json({ status: 'works' });
});

app.use((req, res, next) => {
  res.status(404).json({ error: 'route not found' });
});

app.use((err, req, res, next) => {
  console.log('error: ', err);
  res.status(400).json({ error: err.message });
});

const port = process.env.PORT || 4000;

DbProvider(() => {
  app.listen(port, () => console.log(`Example app listening on port ${port}!`));
});