# aboutbart.com

Bart Kelchtermans' portfolio — hand-written HTML, no build step. What is in this
repository is what is served.

## Deployment

Pushing to `master` deploys the site. It runs on a Docker Swarm cluster behind a
Cloudflare Tunnel, not on GitHub Pages: CI builds an nginx image, pins its tag into
`deploy/swarm/compose.yaml`, and Arcane picks that commit up and redeploys.

Full procedure, one-time setup and rollback: **[`deploy/README.md`](deploy/README.md)**.

One thing to know before editing: internal links here are extensionless (`href="about"`).
`deploy/swarm/nginx.conf` resolves them, and 301s the `.html` forms to the extensionless
one so each page has a single canonical URL.
