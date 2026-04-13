# HandConnect - Advanced Hand Tracking AR

An immersive hand tracking AR experience using MediaPipe with neon effects, particle systems, and audio feedback.

## Features

- Real-time hand detection using MediaPipe
- Multiple visual themes (Rainbow, Cyberpunk, Lava, Ocean, Galaxy)
- Particle effects and shockwaves
- Matrix rain background effects
- Gesture detection (pinch, open/closed hand)
- Audio feedback with humming and zap sounds
- Cross-hand lightning effects

## Quick Start

1. Open `index.html` in a modern web browser
2. Grant camera permissions when prompted
3. Click "Enter Experience" to start
4. Move your hands in front of the camera

## Local Development

```bash
# Using Python
python3 -m http.server 8000

# Using Node.js
npx serve .

# Then visit http://localhost:8000
```

## Deployment

### GitHub Pages
1. Push to GitHub repository
2. Enable GitHub Pages in repository settings
3. Select source branch (usually `main`)

### Netlify
1. Drag and drop project folder to https://app.netlify.com/drop
2. Or connect GitHub repository for auto-deployment

### Vercel
```bash
npm i -g vercel
vercel --prod
```

### Surge.sh
```bash
npm i -g surge
surge
```

## Requirements

- Modern web browser with WebRTC support
- Camera access
- HTTPS (required for camera access in production)

## Browser Support

- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

## License

MIT
