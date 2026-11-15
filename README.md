# windows-vm

Run a Windows VM on Linux, inside a Docker container, using [dockur/windows](https://github.com/dockur/windows) (QEMU/KVM).
The Windows ISO is downloaded automatically from Microsoft and installed unattended.

## Requirements

- Linux with KVM (`/dev/kvm`)
- Docker with the compose plugin
- ~70 GB of free disk, 8 GB of RAM for the VM
- Optional: `xfreerdp3` (FreeRDP 3) for `make rdp`

## Usage

```bash
cp .env.example .env   # optional: version, language, RAM, CPU, password...
make up                # first run: download + unattended install (~20 min)
make logs              # follow progress
```

Then open <http://localhost:8006> (web viewer), or connect via RDP on `localhost:3389` (`make rdp`).

- `make down`: graceful shutdown, the disk is kept in `./storage`
- To reset the VM, run `make down` then delete the `./storage` directory
- `./shared` is visible in Windows as a network share (`\\host.lan\Data`)
- Ports are bound to `127.0.0.1` only

## Windows license

No Windows license is required:

- `WIN_VERSION=11` (default): Windows 11 Pro, **not activated**. Fully usable, with a watermark
  and personalization settings disabled.
- `WIN_VERSION=11e`: Windows 11 Enterprise **evaluation**, free for 90 days.

To activate later, enter a product key in Windows settings.
