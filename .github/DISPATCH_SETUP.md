# Cross-repo deploy dispatch setup

`notify-buckit-site.yml` triggers [xdevbase-nx deploy-cloudflare](https://github.com/XD-Builder/xdevbase-nx/blob/main/.github/workflows/deploy-cloudflare.yml) when docs merge to `main` and **Validate docs build** succeeds.

## Secret

Add to **buckit-io/docs** → Settings → Secrets and variables → Actions:

| Name | Description |
|------|-------------|
| `XDEVBASE_DISPATCH_TOKEN` | PAT that can dispatch workflows on `XD-Builder/xdevbase-nx` |

### Fine-grained PAT (recommended)

1. GitHub → Settings → Developer settings → Fine-grained tokens → Generate
2. Resource owner: your user or org that can access `XD-Builder/xdevbase-nx`
3. Repository access: **Only select repositories** → `XD-Builder/xdevbase-nx`
4. Permissions: **Actions** → Read and write (or **Contents** → Read if Actions write is unavailable; repository dispatch requires sufficient repo access)
5. Copy token → add as `XDEVBASE_DISPATCH_TOKEN` on `buckit-io/docs`

### Classic PAT

Scope: `repo` (if xdevbase-nx is private) or a token with access to dispatch on the target repo.

## Verify

1. Merge xdevbase-nx deploy workflow changes first
2. Manually run **Deploy to Cloudflare Pages** on xdevbase-nx with `docs_ref` set to a docs commit SHA
3. Merge a docs change to `main` and confirm:
   - Validate docs build → success
   - Notify buckit.sh deploy → success
   - xdevbase-nx **Deploy to Cloudflare Pages** run triggered by `docs-updated`

## Branch protection

On `buckit-io/docs` `main`, require the **Validate docs build** check on pull requests.
