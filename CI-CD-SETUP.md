# CI/CD Pipeline Setup Guide for HandConnect

This guide explains how to set up and use the complete CI/CD pipeline for your HandConnect project.

## Overview

The CI/CD pipeline includes:
- **Continuous Integration**: Automated testing and building on every push
- **Continuous Deployment**: Automatic deployment to multiple platforms
- **Docker Support**: Containerization for consistent environments
- **Multiple Deployment Targets**: GitHub Pages, Vercel, Netlify

## Files Created

1. **`.github/workflows/ci-cd.yml`** - Main GitHub Actions workflow
2. **`Dockerfile`** - Docker container configuration
3. **`nginx.conf`** - Nginx web server configuration
4. **`vercel.json`** - Vercel deployment configuration
5. **`netlify.toml`** - Netlify deployment configuration

## Setup Instructions

### 1. GitHub Actions (Required)

The pipeline is automatically triggered when you push to the `main` branch.

**To enable GitHub Pages deployment:**
1. Go to your repository on GitHub
2. Click **Settings** > **Pages**
3. Under "Build and deployment", select **GitHub Actions** as the source
4. The pipeline will automatically deploy to GitHub Pages

### 2. Vercel Deployment (Optional)

**Setup:**
1. Create a Vercel account at [vercel.com](https://vercel.com)
2. Import your GitHub repository
3. Get your Vercel credentials:
   - Vercel Token: Settings > Tokens > Create New
   - Organization ID: From Vercel dashboard URL
   - Project ID: From project settings

**Add GitHub Secrets:**
```bash
# In your GitHub repository:
# Settings > Secrets and variables > Actions > New repository secret
VERCEL_TOKEN=your_vercel_token
VERCEL_ORG_ID=your_org_id
VERCEL_PROJECT_ID=your_project_id
```

### 3. Netlify Deployment (Optional)

**Setup:**
1. Create a Netlify account at [netlify.com](https://netlify.com)
2. Connect your GitHub repository
3. Get your Netlify credentials:
   - Auth Token: User settings > Applications > New access token
   - Site ID: From site settings > General > Site details

**Add GitHub Secrets:**
```bash
NETLIFY_AUTH_TOKEN=your_netlify_token
NETLIFY_SITE_ID=your_site_id
```

### 4. Docker Hub (Optional)

To push Docker images to Docker Hub:

**Add GitHub Secrets:**
```bash
DOCKER_USERNAME=your_docker_username
DOCKER_PASSWORD=your_docker_password
```

Then uncomment the Docker Hub login steps in the workflow file.

## Pipeline Jobs

### 1. build-and-test
- Checks out code
- Sets up Node.js environment
- Installs dependencies (if package.json exists)
- Runs tests (if available)
- Builds project (if build script exists)
- Validates HTML syntax
- Uploads artifacts for deployment

### 2. docker-build (Optional)
- Builds Docker image
- Tests container functionality
- Pushes to Docker Hub (if configured)

### 3. deploy-github-pages
- Deploys to GitHub Pages
- Automatic on main branch pushes

### 4. deploy-vercel (Optional)
- Deploys to Vercel
- Requires Vercel secrets

### 5. deploy-netlify (Optional)
- Deploys to Netlify
- Requires Netlify secrets

### 6. notify
- Sends deployment status notifications
- Updates GitHub Actions summary

## Local Development

### Running with Docker
```bash
# Build the Docker image
docker build -t handconnect .

# Run the container
docker run -p 8080:80 handconnect

# Access at http://localhost:8080
```

### Running without Docker
```bash
# Using Python
python3 -m http.server 8000

# Using Node.js
npx serve .

# Access at http://localhost:8000
```

## Testing the Pipeline

1. **Make changes** to your project
2. **Commit and push** to the main branch:
   ```bash
   git add .
   git commit -m "Test CI/CD pipeline"
   git push origin main
   ```
3. **Monitor the workflow** in GitHub Actions tab
4. **Check deployment** at the provided URLs

## Troubleshooting

### Common Issues

**GitHub Pages deployment fails:**
- Ensure GitHub Pages is enabled in repository settings
- Check that the workflow has proper permissions
- Verify the build artifacts are uploaded correctly

**Vercel deployment fails:**
- Check that Vercel secrets are correctly set
- Verify the Vercel project is connected to GitHub
- Ensure the Vercel token has proper permissions

**Docker build fails:**
- Check that Dockerfile exists in the project root
- Verify the nginx.conf file is present
- Ensure index.html exists in the project root

**Tests fail:**
- Check that test scripts are properly defined in package.json
- Verify all test dependencies are installed
- Review test logs for specific error messages

### Getting Help

1. **Check GitHub Actions logs** for detailed error messages
2. **Review the workflow file** for any syntax errors
3. **Verify secrets** are correctly configured
4. **Test locally** before pushing to main branch

## Best Practices

1. **Branch protection**: Enable branch protection for main branch
2. **Status checks**: Require CI/CD checks to pass before merge
3. **Secrets management**: Never commit secrets to the repository
4. **Regular updates**: Keep GitHub Actions and dependencies updated
5. **Monitor deployments**: Regularly check that deployments are working

## Performance Optimization

The pipeline includes:
- **Artifact caching** for faster builds
- **Parallel job execution** for efficiency
- **Conditional deployments** to save resources
- **Health checks** for Docker containers
- **Gzip compression** for better performance

## Security Features

- **Security headers** in Nginx configuration
- **Content Security Policy** for XSS protection
- **Permissions policy** for camera/microphone access
- **HTTPS enforcement** in production
- **Secret management** through GitHub Secrets

## Next Steps

1. **Configure your preferred deployment targets**
2. **Set up monitoring and alerts**
3. **Add custom domain names** if needed
4. **Implement additional tests** as your project grows
5. **Set up staging environments** for testing

---

For questions or issues, check the GitHub Actions logs or create an issue in the repository.
