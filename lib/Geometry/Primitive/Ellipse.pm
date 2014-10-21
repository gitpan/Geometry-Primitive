package Geometry::Primitive::Ellipse;
use Moose;
use MooseX::AttributeHelpers;
use MooseX::Storage;

use Math::Trig ':pi';

extends 'Geometry::Primitive';

with qw(Geometry::Primitive::Shape MooseX::Clone);
with Storage(format => 'JSON', io => 'File');

has 'height' => ( is => 'rw', isa => 'Num', default => sub { 0 });
has 'origin' => (
    is => 'rw', isa => 'Geometry::Primitive::Point', coerce => 1
);
has 'width' => ( is => 'rw', isa => 'Num', default => sub { 0 });

sub area {
    my ($self) = @_;
    return (pi * $self->width * $self->height) / 4;
};

sub point_end {
    my ($self) = @_;

    return $self->point_start;
}

sub point_start {
    my ($self) = @_;

    return Geometry::Primitive::Point->new(
        x => $self->origin->x,
        y => $self->origin->y - ($self->height / 2)
    );
}

sub scale {
    my ($self, $amount) = @_;

    return Geometry::Primitive::Ellipse->new(
        height => $self->height * $amount,
        width => $self->width * $amount
    );
}

__PACKAGE__->meta->make_immutable;

no Moose;
1;

__END__

=head1 NAME

Geometry::Primitive::Ellipse - An Ellipse

=head1 DESCRIPTION

Geometry::Primitive::Ellipse represents an elliptical conic section.

=head1 SYNOPSIS

  use Geometry::Primitive::Ellipse;

  my $ellipse = Geometry::Primitive::Ellipse->new(
      width => 15,
      height => 10
  );
  print $ellipse->area;

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Geometry::Primitive::Ellipse

=back

=head2 Instance Methods

=over 4

=item I<area>

Returns the area of this ellipse.

=item I<height>

Set/Get the height of this ellipse.

=item I<origin>

Set/Get the origin of this ellipse.

=item I<point_end>

Gets the "end" point for this Ellipse.  Same as C<point_start>.

=item I<point_start>

Get the point that "starts" this Ellipse.  Returns the a point where the X
coordinate is the Ellipse origin X and the origin Y + height / 2.

=item I<scale ($amount)>

Returns a new ellipse whose radius is $amount times bigger than this one.

=item I<width>

Set/Get the width of this ellipse.

=back

=head1 AUTHOR

Cory Watson <gphat@cpan.org>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

You can redistribute and/or modify this code under the same terms as Perl
itself.