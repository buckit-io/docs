# Buckit Documentation

This repository contains the documentation source for [Buckit](https://github.com/buckit-io/buckit) object storage.

The site is built with Sphinx for content generation and Gulp for frontend asset compilation.
This project extends the original open source [MinIO docs project](https://github.com/minio/docs), which is discontinued, for Buckit-specific documentation and maintenance.
This project and Buckit are not affiliated with MinIO in anyway.

## Prerequisites

- macOS or Linux
- Python 3.10+
- `python3-venv`
- Node.js and npm
- `git`

## Local Setup

1. Clone this repository and enter it.

```bash
git clone https://github.com/buckit-io/docs.git
cd docs
```

2. Create and activate a virtual environment.

```bash
python3 -m venv venv
source venv/bin/activate
```

3. Install Python and Node dependencies.

```bash
pip install -r requirements.txt
npm install
```

## Build

Build the Buckit docs locally with:

```bash
npm run build
make docs
```

The generated site is written to:

```bash
build/$(git branch --show-current)/docs/html
```

To preview the built site locally:

```bash
python3 -m http.server --directory build/$(git branch --show-current)/docs/html 8000
```

Then open `http://localhost:8000`.

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for contribution guidelines.

## License

See [LICENSE](./LICENSE).
