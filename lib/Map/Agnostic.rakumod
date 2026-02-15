use Hash::Agnostic:ver<0.0.19+>:auth<zef:lizmat>;

role Map::Agnostic does Hash::Agnostic {
    has int $!initialized;

#---- Methods supplied by Map::Agnostic needed by Hash::Agnostic ---------------
    method ASSIGN-KEY(::?ROLE:D: \key, \value) {
        if $!initialized {
            my str $type = self.EXISTS-KEY(key) ?? 'change' !! 'add';
            die "Cannot $type key '" ~ key ~ "' in an immutable " ~ self.^name;
        }
        else {
            self.INIT-KEY(key, value)
        }
    }

    method BIND-KEY(::?ROLE:D: \key, \value) {
        X::Bind.new(target => self.^name).throw;
    }

    method DELETE-KEY(::?ROLE:D: \key) {
        die "Can not remove values from a " ~ self.^name;
    }

    method STORE(::?ROLE:D: \iterable, :$INITIALIZE!) {
        if $INITIALIZE {
            self.Hash::Agnostic::STORE(iterable, :INITIALIZE);
            $!initialized = 1;  # UNCOVERABLE
            self
        }
        else {
            die "Can not re-initialize a " ~ self.^name;
        }
    }

#---- Methods needed by Map::Agnostic ------------------------------------------
    method INIT-KEY(\key, \value) { ... }  # UNCOVERABLE

#---- Methods not allowed by Maps ----------------------------------------------
    method append(|) {
        die "Can not append values to a " ~ self.^name;
    }
    method grab(|) {
        die "Can not grab values from a " ~ self.^name;
    }
    method push(|) {
        die "Can not push values to a " ~ self.^name;
    }
}

# vim: expandtab shiftwidth=4
