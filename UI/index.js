const express = require('express');
const app = express();
const port = 3000;

// Serve files in the "public" folder
app.use(express.static('public'));

app.listen(port, () => {
  console.log(`UI server running at http://localhost:${port}`);
});
