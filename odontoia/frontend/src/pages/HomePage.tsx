import { Box, Button, Typography } from '@mui/material';

export default function HomePage() {
  return (
    <Box sx={{ textAlign: 'center', mt: 8 }}>
      <Typography variant="h3" component="h1" gutterBottom>
        ODONTOIA
      </Typography>
      <Button variant="contained">Botón de prueba</Button>
    </Box>
  );
}
