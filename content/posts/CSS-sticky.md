---
title: CSS Sticky is Fun
date: 2021-08-20T00:30:00+09:00
draft: false
---

# CSS Sticky is Fun

I am working on an experimental Codefun frontend, codenamed *Mashiro*, written completely in Elm using the Tailwind.css "framework".

The UI's main idea is to capture most content into card-like objects floating on a greeny background. Something like this:

![Screen Shot 2021-08-20 at 0.15.26](/images/css-sticky-layout.png)

You can see that the main "Problems" represent a floating card, while the left side navbar represents some more floating cards.

## Let's make a Sticky card header!

In a moment I had a bright idea of keeping that `Problems` header on top of the card, inside the view while it is being scrolled. 

This made sense: the navigation bar is right to the right (!) of the header, so it should be accessible from any scrolling. OK, so how about making it sticky?

Here's the basic layout of the page:

```yaml
body:
	nav#topBar.sticky.top-0.h-14:
		... # the basic top bar
	main.mt-14.relative:
		nav#sideNav.fixed: The side navigations
		content:
			# The actual body
			card:
				card-title.sticky.top-0
```

Now as some of you might have already figured out, this layout actually does not provide what we want at all. 

To see why, let's look at the description of `position: sticky` on [MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/position):

> The element is positioned according to the normal flow of the document, and then offset relative to its *nearest scrolling ancestor* and [containing block](https://developer.mozilla.org/en-US/docs/Web/CSS/Containing_block) (nearest block-level ancestor), including table-related elements, based on the values of `top`, `right`, `bottom`, and `left`. The offset does not affect the position of any other elements.

Note that the offset is relative to the "nearest scrolling ancestor". What is the nearest scrolling ancestor? It's basically anything that gives a scrolling bar. At the base level, it's the `body` element itself, when its height exceeds the screen (this is why the top bar sticks to the top).

So what we've done here is just sticking the card header to under the top bar. Not what we wanted.

We want to make a "scrolling ancestor" out of the `main` element, since it's what we want the card header to stick to. OK, let's do it.
Note that the simplest way to make something a "scrolling ancestor" is just to stick an overflow value to it:

```diff
- main.mt-14.relative:
+ main.mt-14.relative.overflow-auto:
```

Is it working yet? 

## Why wouldn't you scroll?

Unfortunately we've come closer, but not yet done. Now that we've locked the card header to the top of `main`, we've actually made the behavior worse: *the header now scrolls away with the `main` element*. 

Why is this happening? Note that, when we scroll the page, it's not the `main` element that was scrolling: it's actually `body`. This does not interact with the logic of `sticky`, so we are just scrolling over the element now.

To fix this, we will need to completely **move the scrolling from `body` to `main`**. This can be done by limiting the height of `main`:

```diff
- main.mt-14.relative.overflow-auto:
+ main.mt-14.relative.overflow-auto.max-h-screen
```

Is it working yet?

{{< video src="/clips/css-sticky-works.mov" >}}

:tada:
