use Hash::Agnostic:ver<0.0.17+>:auth<zef:lizmat>;

role Map::Agnostic does Hash::Agnostic {
    has int $!initialized;

#---- Methods supplied by Map::Agnostic needed by Hash::Agnostic ---------------
    method ASSIGN-KEY(::?ROLE:D: \key, \value) {
        $!initialized
          ?? (die "Cannot change key '{key}' in an immutable {self.^name}")
          !! self.INIT-KEY(key, value)
    }

    method BIND-KEY(::?ROLE:D: \key, \value) {
        X::Bind.new(target => self.^name).throw;
    }

    method DELETE-KEY(::?ROLE:D: \key) {
        die "Can not remove values from a {self.^name}";
    }

    multi method STORE(::?ROLE:D: \iterable, :$INITIALIZE!) {
        callsame;
        $!initialized = 1;
        self
    }

#---- Methods needed by Map::Agnostic ------------------------------------------
    method INIT-KEY(\key, \value) { ... }

#---- Methods not allowed by Maps ----------------------------------------------
    method append(|) {
        die "Can not append values to a {self.^name}";
    }
    method grab(|) {
        die "Can not grab values from a {self.^name}";
    }
    method push(|) {
        die "Can not push values to a {self.^name}";
    }
}

# vim: expandtab shiftwidth=4
