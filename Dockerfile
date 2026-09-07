# syntax=docker/dockerfile:1
# Static site image for the Pi swarm — see deploy/README.md.
#
# No build stage: this repo IS the site (hand-written HTML, vendored CSS/JS).
# Only the nginx layer differs per architecture, so the multi-arch build is
# a file copy on each leg.
FROM nginx:1.30-alpine
COPY . /usr/share/nginx/html
# deploy/ has to be in the build context (the server block lives there), so
# it arrives with everything else and is moved into place and dropped here —
# a .dockerignore entry would hide it from the COPY above as well.
RUN mv /usr/share/nginx/html/deploy/swarm/nginx.conf /etc/nginx/conf.d/default.conf \
 && rm -rf /usr/share/nginx/html/deploy
# start-first rollouts gate on this: a task is "running" only once it answers.
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
    CMD wget -qO /dev/null http://127.0.0.1/ || exit 1
