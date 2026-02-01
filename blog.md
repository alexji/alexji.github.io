---
layout: default
permalink: /blog/
title: Blog
order: 10
---
<!-- Tag buttons -->
<div class="tag-filter" style="margin-bottom: 20px;">
  <strong>Filter by tag:</strong>
  <button class="tag-btn active" data-tag="all">All</button>
  {% assign all_tags = site.posts | map: 'tags' | flatten | uniq | sort %}
  {% for tag in all_tags %}
    <button class="tag-btn" data-tag="{{ tag }}">{{ tag }}</button>
  {% endfor %}
</div>

<!-- Posts list -->
<ul class="post-list">
  {% for post in site.posts %}
    <li class="post-item" data-tags="{{ post.tags | join: ',' }}">
      <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
      <h2>
        <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
      </h2>
      {% if post.tags %}
      <div class="post-tags">
        {% for tag in post.tags %}
          <a href="#{{ tag }}" class="tag">{{ tag }}</a>{% unless forloop.last %}, {% endunless %}
        {% endfor %}
      </div>
      {% endif %}
    </li>
  {% endfor %}
</ul>

<script>
function filterByTag(selectedTag) {
  // Update active button
  document.querySelectorAll('.tag-btn').forEach(b => {
    if (b.dataset.tag === selectedTag) {
      b.classList.add('active');
    } else {
      b.classList.remove('active');
    }
  });
  
  // Filter posts
  document.querySelectorAll('.post-item').forEach(post => {
    const postTags = post.dataset.tags.split(',');
    if (selectedTag === 'all' || postTags.includes(selectedTag)) {
      post.style.display = 'list-item';
    } else {
      post.style.display = 'none';
    }
  });
}

// Handle button clicks
document.querySelectorAll('.tag-btn').forEach(btn => {
  btn.addEventListener('click', function() {
    const selectedTag = this.dataset.tag;
    filterByTag(selectedTag);
    if (selectedTag === 'all') {
      history.pushState(null, '', '/blog/');
    } else {
      history.pushState(null, '', '/blog/#' + selectedTag);
    }
  });
});

// Handle clicking tag links
document.querySelectorAll('.post-tags .tag').forEach(link => {
  link.addEventListener('click', function(e) {
    e.preventDefault();
    const tag = this.getAttribute('href').substring(1); // Remove #
    filterByTag(tag);
    window.location.hash = tag;
  });
});

// Handle loading page with #tag in URL
window.addEventListener('load', function() {
  const hash = window.location.hash.substring(1);
  if (hash) {
    filterByTag(hash);
  }
});
</script>

<style>
.tag-btn {
  margin: 5px;
  padding: 5px 10px;
  cursor: pointer;
  border: 1px solid #ccc;
  background: #f5f5f5;
  border-radius: 3px;
}
.tag-btn.active {
  background: #333;
  color: white;
}
.tag {
  background: #eee;
  padding: 2px 6px;
  border-radius: 3px;
  font-size: 0.9em;
}
</style>
