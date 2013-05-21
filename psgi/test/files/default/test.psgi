my $app = sub {
      my $env = shift;
      my @data;
      for my $id (%ENV) {
        push @data, "$id:$ENV{$id}"
      }
      return [
          '200',
          [ 'Content-Type' => 'text/plain' ],
          [ "Hello World",  join "\n", @data ], # or IO::Handle-like object
      ];
  };

