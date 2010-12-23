module GoogleAnalytics
  include Radiant::Taggable


  desc %{
  Creates Google Analytics code with id content
    *Usage:*
    <pre><code><r:google_analytics id="YOUR_ID" [type="s"] [domain="domain.com"]</code></pre>
    *Attributes:*

    * @id@ your id
    * @type@ defaults to 's', other options 'sub' or 'multi'
    * @domain@ needed for type 'sub'

  }
  tag "google_analytics" do |tag|
    type = tag.attr['type'] || 's' # single domain 's' OR with many subdomain 'm'
    script = case type
              when 's' then
       %{<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', '#{tag.attr['id']}']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>}
              when 'sub'  then
       %{<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', '#{tag.attr['id']}']);
  _gaq.push(['_setDomainName', '.#{tag.attr['domain']}']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>}
              when 'multi'   then
       %{<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', '#{tag.attr['id']}']);
  _gaq.push(['_setDomainName', 'none']);
  _gaq.push(['_setAllowLinker', true]);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>}
            end

    script
  end
end
