#Pantheon Files does not export the plugin dir in package?
files_plugin_dir=join_paths(get_option('prefix'), get_option('libdir'), parent_project_name, 'plugins')

shared_module (
    meson.project_name(),
#    'Application.vala',
    'BulkRenamer.vala',
    'Enums.vala',
    'Modifier.vala',
    'Window.vala',
    'plugin.vala',
    dependencies: [
        core_deps,
        dependency('gtk+-3.0'),
        dependency('granite'),
        posix_dep
    ],
    install : true,
    install_dir : files_plugin_dir
)

install_data(
    'io.github.jeremypw.bulk-renamer.plug',
    install_dir: files_plugin_dir,
)
