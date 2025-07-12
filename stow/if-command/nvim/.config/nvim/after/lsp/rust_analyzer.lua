return {
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
                extraArgs = {
                    "--",
                    "-D",
                    "clippy::pedantic",
                    "-D",
                    "clippy::nursery",
                    "-A",
                    "clippy::cast_precision_loss",
                },
            },
        },
    },
}
