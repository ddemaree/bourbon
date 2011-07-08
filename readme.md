# Bourbon: A standard library for Sass

Bourbon is delicious. It is also a standard library of Sass mixins (in SCSS syntax) providing robust, cross-browser CSS3 effects, preserving graceful degradation through browser prefixes where possible, but also not straying too far from the vanilla CSS syntax. CSS3 properties are specified as a stack in the order recommended by Dan Cederholm in [_CSS3 For Web Designers_](http://www.abookapart.com/products/css3-for-web-designers) (2009, A Book Apart).

Here's an example:
    
    // Instead of doing this:
    a.tab-button {
        -webkit-border-radius: 2px 2px 0 0;
        -moz-border-radius: 2px 2px 0 0;
        -ms-border-radius: 2px 2px 0 0;
        -o-border-radius: 2px 2px 0 0;
        border-radius: 2px 2px 0 0;
    }
    
    // Do this, it's equivalent:
    @import 'bourbon';
    
    a.tab-button {
        @include border-radius(2px 2px 0 0);
    }


It also provides some useful functions for calculating modular scales based on the golden ratio (based in part on [the excellent work of Tim Brown](http://modularscale.com)), and grid widths (with support for fluid grid calculation coming soon).

This version of Bourbon is forked from the one at <http://github.com/thoughtbot/bourbon>, by Phil LaPier and Chad Mazzola. Mad props to those guys for releasing this.

These mixins/functions require Sass 3.1.1 or later. While Thoughtbot's core Bourbon library has a lot of twiddly knobs enabling support for non-Rails (or older Rails) projects, _this_ Bourbon is strictly to be used as a Rails engine in Rails 3.1 or later. A method for adding Bourbon mixins to the Sass load path in Sinatra or other Rack apps is on the todo list, but not here yet. The "copy into your project" approach Phil, Chad, et al have taken is okay, but is less okay than being able to simply include this CSS into one's app using Bundler, git, Sass, and the asset pipeline.

#Install for Rails
Update your Gemfile

    gem 'bourbon', :git => 'https://github.com/ddemaree/bourbon.git'
    
    bundle install

##Rails 3.1.x

Import the mixins at the beginning of any stylesheet that uses them.

    @import 'bourbon';
    
Note that because [Sprockets](http://github.com/sstephenson/sprockets), Rails's asset-serving framework, compiles SCSS files *before* requiring them into the main stylesheet, if you're using multiple `.scss` files in your project you'll need to require Bourbon (or any other mixins, for that matter) into each one individually.

To use the reset or normalize stylesheets, just include them via Sprockets (this will _only_ work in Rails 3.1):
    
    /*
    * This will load: Bourbon's reset stylesheet, the current sheet,
    *   then everything else
    *= require reset
    *= require_self
    *= require_tree .
    */

# Using Bourbon mixins

Below are a few examples of mixin usage. Note that these are just a few, explore the repo to find out more.

###Animation

The animation mixins support comma separated lists of values, which allows different transitions for individual properties to be described in a single style rule. Each value in the list corresponds to the value at that same position in the other properties.

    @include animation-name(slideup, fadein);
    @include animation-duration(1.0s, 1.2s);
    @include animation-timing-function(ease-in-out, ease-out);

    # Shorthand for a basic animation. Supports multiple parentheses-deliminated values for each variable.
    @include animation-basic((slideup, fadein), (1.0s, 2.0s), ease-in);


###Border Radius

Border-radius will also take short-hand notation.

    @include border-radius(10px);
    @include border-radius(5px 5px 2px 2px);


###Box Shadow

Box-Shadow supports single or multiple arguments:

    @include box-shadow(1px 1px 2px 0 #ff0000);

    # Multiple arguments must be comma-diliminated.
    @include box-shadow(1px 1px 2px 0 #fff0000, -1px -2px 0 #ccc);


###Box Sizing

Box-sizing will change the box-model of the element it is applied to.

    @include box-sizing(border-box);


###Flex Box

The flex-box mixin is based on the 2009 w3c spec. The mixin with change to the flexible box-model. [More info.](http://www.w3.org/TR/2009/WD-css3-flexbox-20090723/)

    div.parent {
      @include display-box;
      @include box-align(start);
      @include box-orient(horizontal);
      @include box-pack(start);
    }

    div.parent > div.child {
      @include box-flex(2);
    }


###Inline-block

The inline-block mixin provides support for the inline-block property in IE6 and IE7.

    @include inline-block;


###Linear-Gradient

Gradient position is optional, default is top. Position can be a degree. Color-stops are optional as well. Mixin will support up to 10 gradients.

    @include linear-gradient(#1e5799, #2989d8);
    @include linear-gradient(top, #1e5799 0%, #2989d8 100%);
    @include linear-gradient(50deg, #1e5799 0%, #2989d8 50%, #207cca 51%, #7db9e8 100%);


###Position

Shorthand notation for setting the position of elements in your page.

Instead of writing:

    position: relative;
    top: 0px;
    left: 100px;

You can write:

    @include position(relative, 0px 0 0 100px);

The first parameter is optional, with a default value of relative. The second parameter is a space delimited list of values that follow the standard CSS shorthand notation.

Note: unitless values will be ignored. In the example above, this means that selectors will not be generated for the right and bottom positions, while the top position is set to 0px.


###Radial-Gradient

Takes up to 10 gradients. Position and shape are required.

    @include radial-gradient(50% 50%, circle cover, #1e5799, #efefef);
    @include radial-gradient(50% 50%, circle cover, #eee 10%, #1e5799 30%, #efefef);


###Transform

    @include transform(translateY(50px));


###Transitions

Shorthand mixin: Supports multiple parentheses-deliminated values for each variable.

    @include transition (all, 2.0s, ease-in-out);
    @include transition ((opacity, width), (1.0s, 2.0s), ease-in, (0, 2s));
    @include transition ($property:(opacity, width), $delay: (1.5s, 2.5s));`


##Functions
###Compact

The compact function will strip out any value from a list that is 'false'. Takes up to 10 arguments.

    $full:  compact($name-1, $name-2, $name-3, $name-4, $name-5, $name-6, $name-7, $name-8, $name-9, $name-10);


###Golden Ratio

Returns the golden ratio of a given number. Must provide a Pixel or Em value for first argument. Also takes a required increment value that is not zero and an integer: ...-3, -2, -1, 1, 2, 3...

    div {
                    Increment Up GR with positive value
      width:        golden-ratio(14px,  1);    // returns: 22.652px

                    Increment Down GR with negative value
      width:        golden-ratio(14px, -1);    // returns: 8.653px

                    Can be used with ceil(round up) or floor(round down)
      width: floor( golden-ratio(14px,  1) );  // returns: 22px
      width:  ceil( golden-ratio(14px,  1) );  // returns: 23px
    }

Resources: [modularscale.com](http://modularscale.com) & [goldenratiocalculator.com](http://goldenratiocalculator.com)


###Grid-width

Easily setup and follow a grid based design. Need help gridding? Check out [gridulator.com](http://gridulator.com/)

    # The $gw-column and $gw-gutter variables must be defined in your base stylesheet to properly use the grid-width function.
    $gw-column: 100px;          // Column Width
    $gw-gutter: 40px;           // Gutter Width

    div {
      width: grid-width(4);     // returns 520px;
      margin-left: $gw-gutter;  // returns 40px;
    }


###Tint & Shade

Tint & shade are different from lighten() and darken() functions built into sass.  
Tint is a mix of a color with white. Tint takes a color and a percent argument.

    div {
      background: tint(red, 40%);
    }

Shade is a mix of a color with black. Shade takes a color and a percent argument.

    div {
      background: shade(blue, 60%);
    }


##Add-ons

###Buttons

The button add-on provides well-designed buttons with a single line in your CSS. The demo folder contains examples of the buttons in use.  
The mixin can be called with no parameters to render a blue button with the "simple" style.

    button,
    input[type="button"] {
      @include button;
    }

The mixin supports a style parameter. Right now the available styles are "simple" (default), "shiny", and "pill".

    button,
    input[type="button"] {
      @include button(shiny);
    }

The real power of the mixin is revealed when you pass in the optional color argument. Using a single color, the mixin calculates the gradient, borders, box shadow, text shadow and text color of the button. The mixin will change the text to be light when on a dark background, and dark when on a light background.

    button,
    input[type="button"] {
      @include button(shiny, #ff0000);
    }


#All Supported Functions, Mixins, and Addons
*@ denotes a mixin and must be prefaced with @include*

    #Functions
    --------------------------------
      compact(*args)
      golden-ratio(*args)
      grid-width(*args)
      shade(*args)
      tint(*args)

    #Mixins
    --------------------------------
      animation
        @ animation(*args)
        @ animation-basic(*args)
        @ animation-delay(*args)
        @ animation-direction(*args)
        @ animation-duration(*args)
        @ animation-fill-mode(*args)
        @ animation-iteration-count(*args)
        @ animation-name(*args)
        @ animation-play-state(*args)
        @ animation-timing-function(*args)

      @ border-radius(*args)
      @ box-sizing(*args)

      flex-box
        @ box-align(*args)
        @ box-direction(*args)
        @ box-flex(*args)
        @ box-flex-group(*args)
        @ box-lines(*args)
        @ box-ordinal-group(*args)
        @ box-orient(*args)
        @ box-pack(*args)
        @ display-box

      @ inline-block
      @ linear-gradient(*args)
      @ radial-gradient(*args)
      @ transform(*args)

      transition
        @ transition(*args)
        @ transition-delay(*args)
        @ transition-duration(*args)
        @ transition-property(*args)
        @ transition-timing-function(*args)

    #Addons
    --------------------------------
    @ button(*args)
    @ position(*args)


##Help Out

Currently the project is a work in progress. Feel free to help out.

Credits
-------

This fork of Bourbon is maintained by [David Demaree](http://log.demaree.me). It's based on work originally funded and released as open source by [thoughtbot, inc](http://thoughtbot.com/community) in 2011.

License
-------

Bourbon is free software, and may be redistributed under the terms specified in the LICENSE file.
