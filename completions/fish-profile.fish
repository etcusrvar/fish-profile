complete -c fish-profile -l help -d "Show this help message and exit"
complete -c fish-profile -l prune -d "Prune orphaned private history files"
complete -c fish-profile -l use -d "Switch to PROFILE in current session"

function __fish_profile_completion_names
    # Parse existing history files for names of previously used profiles
    for f in $__fish_user_data_dir/*_history
        printf "%s\n" (
            basename $f |
            grep -v '^private_' |
            sed -E "s/(_[0-9]+)*_history//"
        )
    end
end

complete -c fish-profile -xa "(__fish_profile_completion_names)"
