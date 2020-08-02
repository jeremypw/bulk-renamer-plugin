/***
    Authors:
      Lucas Baudin <xapantu@gmail.com>
      ammonkey <am.monkeyd@gmail.com>
      Victor Martinez <victoreduardm@gmail.com>

    Copyright (c) Lucas Baudin 2011 <xapantu@gmail.com>
    Copyright (c) 2013-2018 elementary LLC <https://elementary.io>

    Marlin is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the
    Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Marlin is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program.  If not, see <http://www.gnu.org/licenses/>.
***/

public class Marlin.Plugins.RenamerMenuItem : Gtk.MenuItem {
    private File[] files;

    public RenamerMenuItem (File[] files) {
        this.files = files;

        label = _("Rename Selected Files");

warning ("Menuitem has %u files", files.length);
    }

    public override void activate () {
warning ("Activate with %u files", files.length);
        var dialog = new RenamerDialog ("", files);
        dialog.run ();
        dialog.destroy ();
    }
}

public class Marlin.Plugins.BulkRenamer : Marlin.Plugins.Base {
    private Gtk.Menu menu;
    private GOF.File current_directory = null;

    public BulkRenamer () {
    }

    public override void context_menu (Gtk.Widget widget, List<GOF.File> gof_files) {
        menu = widget as Gtk.Menu;

        File[] files = null;
        if (gof_files == null) {
            return;
        }

        files = get_file_array (gof_files);

        var menu_item = new RenamerMenuItem (files);
        add_menuitem (menu, menu_item);
    }

    public override void directory_loaded (Gtk.ApplicationWindow window, GOF.AbstractSlot view, GOF.File directory) {
        current_directory = directory;
    }

    private void add_menuitem (Gtk.Menu menu, Gtk.MenuItem menu_item) {
        menu.append (menu_item);
        menu_item.show ();
        plugins.menuitem_references.add (menu_item);
    }


    private static File[] get_file_array (List<GOF.File> files) {
        File[] file_array = new File[0];

        foreach (unowned GOF.File file in files) {
            if (file.location != null) {
                if (file.location.get_uri_scheme () == "recent") {
                    file_array += GLib.File.new_for_uri (file.get_display_target_uri ());
                } else {
                    file_array += file.location;
                }
            }
        }

        return file_array;
    }
}

public Marlin.Plugins.Base module_init () {
    return new Marlin.Plugins.BulkRenamer ();
}
