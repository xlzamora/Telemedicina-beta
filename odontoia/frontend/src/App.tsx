import { AppBar, Box, Container, CssBaseline, Toolbar, Typography } from '@mui/material';
import HomePage from './pages/HomePage';

function App() {
  return (
    <>
      <CssBaseline />
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" component="div">
            ODONTOIA
          </Typography>
        </Toolbar>
      </AppBar>
      <Container maxWidth="lg">
        <Box sx={{ py: 4 }}>
          <HomePage />
        </Box>
      </Container>
    </>
  );
}

export default App;
