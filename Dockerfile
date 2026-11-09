# A tiny web server image that runs as a normal (non-root) user, on port 8080
FROM nginxinc/nginx-unprivileged:alpine

# The version text shown in the page footer. GitHub Actions will pass the real
# value later with --build-arg. If nothing is passed, it shows "local".
ARG APP_VERSION=local

# Copy the website into the folder nginx serves files from
COPY site/ /usr/share/nginx/html/

# Put the version into the page, then switch back to the normal user
USER root
RUN sed -i "s/__APP_VERSION__/${APP_VERSION}/" /usr/share/nginx/html/index.html
USER 101

EXPOSE 8080
