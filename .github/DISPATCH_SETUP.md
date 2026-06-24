# Cross-repo deploy dispatch setup

`notify-buckit-site.yml` triggers [xdevbase-nx deploy-cloudflare](https://github.com/XD-Builder/xdevbase-nx/blob/main/.github/workflows/deploy-cloudflare.yml) when docs merge to `main` and **Validate docs build** succeeds.

## Secret

Add to **buckit-io/docs** → Settings → Secrets and variables → Actions:

| Name | Description |
|------|-------------|
| `XDEVBASE_DISPATCH_TOKEN` | PAT that can dispatch workflows on `XD-Builder/xdevbase-nx` |

### Fine-grained PAT (recommended)

`XD-Builder/xdevbase-nx` is a **private** repository. The token must have explicit access to it.

1. GitHub → Settings → Developer settings → Fine-grained tokens → Generate
2. Resource owner: user or org that can access `XD-Builder/xdevbase-nx`
3. Repository access: **Only select repositories** → `XD-Builder/xdevbase-nx`
4. Permissions on that repository:
   - **Actions** → Read and write (required for `repository_dispatch`)
   - **Metadata** → Read (automatic)
5. Copy token → add as `XDEVBASE_DISPATCH_TOKEN` on **buckit-io/docs** (not another repo)

If dispatch returns HTTP 403, the token is missing **Actions: Read and write** on `xdevbase-nx` or was saved on the wrong repository.

### Classic PAT

Scope: **`repo`** (required because `xdevbase-nx` is private).

## Verify

1. Merge xdevbase-nx deploy workflow changes first
2. Manually run **Deploy to Cloudflare Pages** on xdevbase-nx with `docs_ref` set to a docs commit SHA
3. Merge a docs change to `main` and confirm:
   - Validate docs build → success
   - Notify buckit.sh deploy → success
   - xdevbase-nx **Deploy to Cloudflare Pages** run triggered by `docs-updated`

## Branch protection

On `buckit-io/docs` `main`, require the **Validate docs build** check on pull requests.
