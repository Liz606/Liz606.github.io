
{% if not (theme.duoshuo and theme.duoshuo.shortname)
  and not theme.duoshuo_shortname
  and not theme.disqus_shortname
  and not theme.hypercomments_id
  and not theme.youyan_uid %}
  
 {% if theme.gentie_productKey %}
    {% set gentie_productKey = theme.gentie_productKey %}
    <script src="https://img1.cache.netease.com/f2e/tie/yun/sdk/loader.js"></script>
    <script>
    var cloudTieConfig = {
      url: document.location.href, 
      sourceId: "",
      productKey: "{{gentie_productKey}}",
      target: "cloud-tie-wrapper"
    };
    var yunManualLoad = true;
    Tie.loader("aHR0cHM6Ly9hcGkuZ2VudGllLjE2My5jb20vcGMvbGl2ZXNjcmlwdC5odG1s", true);
    </script>
  {% endif %}

{% endif %}