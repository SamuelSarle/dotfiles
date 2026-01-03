return {
	cmd = { "bqnlsp" },
	filetypes = { "bqn" },
	root_markers = { ".git", ".jj" },
	single_file_support = true,
	settings = {},
	docs = {
		description = [[
https://git.sr.ht/~detegr/bqnlsp


`bqnlsp`, a language server for BQN.

The binary depends on the shared library of [CBQN](https://github.com/dzaima/CBQN) `libcbqn.so`.
If CBQN is installed system-wide (using `sudo make install` in its source directory) and `bqnlsp` errors that it can't find the shared library, update the linker cache by executing `sudo ldconfig`.
If CBQN has been installed in a non-standard directory or can't be installed globally pass `libcbqnPath = '/path/to/CBQN'` to the setup function.
This will set the environment variables `LD_LIBRARY_PATH` (Linux) or `DYLD_LIBRARY_PATH` (macOS) to the provided path.

  ]],
	},
}
