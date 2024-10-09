#
# GitEmail
#
# GitEmail is a supa-dupa cool tool for making you development easier - shows the email that will probably be used by git to commit your changes.

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GITEMAIL_SHOW="${SPACESHIP_GITEMAIL_SHOW=true}"
SPACESHIP_GITEMAIL_ASYNC="${SPACESHIP_GITEMAIL_ASYNC=true}"
SPACESHIP_GITEMAIL_PREFIX="${SPACESHIP_GITEMAIL_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_GITEMAIL_SUFFIX="${SPACESHIP_GITEMAIL_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_GITEMAIL_SYMBOL="${SPACESHIP_GITEMAIL_SYMBOL=""}"
SPACESHIP_GITEMAIL_COLOR="${SPACESHIP_GITEMAIL_COLOR="yellow"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show gitemail status
# spaceship_ prefix before section's name is required!
# Otherwise this section won't be loaded.
#

spaceship_gitemail() {
  # If SPACESHIP_GITEMAIL_SHOW is false, don't show gitemail section
  [[ $SPACESHIP_GITEMAIL_SHOW == false ]] && return

  GIT_AUTHOR_EMAIL_ENV="GIT_AUTHOR_EMAIL"
  GIT_COMMITTER_EMAIL_ENV="GIT_COMMITTER_EMAIL"

  if printenv "$GIT_AUTHOR_EMAIL_ENV" >/dev/null 2>&1; then
    local email=$(printenv "$GIT_AUTHOR_EMAIL_ENV")
  else
    local email=$(git config user.email 2>/dev/null)
  fi

  local emailDomain=${email#*@}

  if printenv "$GIT_COMMITTER_EMAIL_ENV" >/dev/null 2>&1; then
    local committerEmail=$(printenv "$GIT_COMMITTER_EMAIL_ENV")
  else
    local committerEmail=""
  fi

  if [[ "$email" != "$committerEmail" && -n "$committerEmail" ]]; then
    emailDomain="${emailDomain} | ${committerEmail#*@}"
  fi

  [[ -z "$emailDomain" ]] && return

  # Display gitemail section
  # spaceship::section utility composes sections. Flags are optional
  spaceship::section::v4 \
    --color "$SPACESHIP_GITEMAIL_COLOR" \
    --prefix "$SPACESHIP_GITEMAIL_PREFIX" \
    --suffix "$SPACESHIP_GITEMAIL_SUFFIX" \
    --symbol "$SPACESHIP_GITEMAIL_SYMBOL" \
    " [$emailDomain]"
}
