{config, pkgs, ...}:

{
  programs.helix = {
    enable = true;
    extraPackages = [ pkgs.marksman ];
    settings = {
      theme = "bogster";
      editor = {
        bufferline = "multiple";
        cursorline = true;
        line-number = "relative";
        rulers = [120];
        true-color = true;
        scroll-lines = 12;
        mouse = true;
      };
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      editor.file-picker = {
        hidden = false;
      };
      editor.indent-guides = {
        character = "╎";
        render = true;
      };
      editor.lsp = {
        enable = true;
        auto-signature-help = true;
        display-messages = true;
        display-inlay-hints = true;
        snippets = false;
        goto-reference-include-declaration = true;
      };
      editor.statusline = {
        left = [ "mode" "spinner" "version-control" "file-name" ];
      };
      keys.normal = {
        C-q = ":quit!";
        q = ":buffer-close";
        C-e = ":new";
        C-up = "rotate_view";
        C-left = ":buffer-previous";
        C-right = ":buffer-next";
        C-down = ":hsplit-new";
        C-s = ":write-buffer-close";
        ret = "insert_mode";
        j = "move_char_left"; 
        k = "move_line_up";
        l = "move_line_down";
        ";" = "move_char_right";
        C-r = ":config-reload";
      };
      keys.insert = {
        C-s = ":w";
        C-o = ":open ~/.dotfiles/helix.nix";
      };
      keys.insert.j = {
        k = "normal_mode";
      };
      keys.normal.g = {
        a = "code_action";
      };
    };
    languages = {
        language-go = [{
          name = "go";
          scope = "source.go";
          injection-regex = "go";
          file-types = ["go"];
          roots = ["go.mod" ".git"];
          language-servers = ["gopls"];
          language-id = "go";
        }];
        language-zig = [{
          name = "zig";
          scope = "source.zig";
          injection-regex = "zig";
          file-types = ["zig"];
          roots = [""];
          language-servers = ["zls"];
          language-id = "zig";
        }];
        language-nix = [{
          name = "nix";
          scope = "source.nix";
          injection-regex = "nix";
          file-types = ["nix"];
          roots = [".nix"];
          language-servers = ["nil"];
          language-id = "nix";
        }];
        language-bash =[{
          name = "bash";
          language-servers = ["bash-language-server"];
        }];
      };
    };
}
