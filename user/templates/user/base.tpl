{% load staticfiles %}
{% load thumbnail %}
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="{% static 'font/font-awesome-4.5.0/css/font-awesome.min.css' %}" media="screen" title="no title" charset="utf-8">
        <link href="{% static 'css/vendors.css' %}" rel="stylesheet">
        <title>{{ user.username }}的主页</title>
        {% block head %}
        {% endblock head %}
        </head>
    <body>
        {% include 'home/navbar.tpl' %}
        <div class="user-container clearfix">
            {% with following_num=user.following.count followers_num=user.followers.count %}
            <div class="user-main clearfix">
                {% if profile.avatar %}
                <div class="user-portrait" style="background-image: url('{{MEDIA_URL}}{{profile.avatar}}')">
                {% else %}
                <div class="user-portrait">
                {% endif %}
                {% if user.id != request.user.id %}
                <a href="#">
                    {% if request.user in user.followers.all %}
                    <button type="button" data-id="{{ user.id }}" data-action="unfollow" id="follow-btn" name="button" class="follow-btn unfollow">取消关注</button>
                    {% else %}
                    <button type="button" data-id="{{ user.id }}" data-action="follow" id="follow-btn" name="button" class="follow-btn follow">关注</button>
                    {% endif %}
                </a>
                {% else %}
                    <a href="{% url 'user:logout' %}">
                    <button type="button" class="follow-btn" style="background-color:#DC143C;">退出登录</button>
                    </a>
                {% endif %}
                </div>
                <div class="user-info">
                    <h2 class="user-name"><i class="fa {% if profile.gender == "f" %}fa-venus{% else %}fa-mars{% endif %}"></i>{{ user.username }}</h2>
                    <h4 class="user-area"><i class="fa fa-location-arrow" aria-hidden="true"></i> {{ profile.location | default:"外星" }}</h4>
                    <h4 class="user-desc">{{ profile.introduction | default:"这个人什么也没写" }}</h4>
                    {% if user.id != request.user.id %}
                    <span><button id="private">私信</button></span>
                    {% endif %}
                </div>
                <a href="{% url 'user:followers' user.id %}">
                    <div class="user-follower">
                        <div class="follow-num">{{ followers_num }}</div>
                        粉丝
                    </div>
                </a>
                <a href="{% url 'user:following' user.id %}">
                    <div class="user-following">
                        <div class="follow-num">{{ following_num }}</div>
                        关注
                    </div>
                </a>
            </div>
            {% endwith %}

            <div class="user-tabs clearfix">
                <a href="{% url 'user:home' user.id %}">
                    <div class="tab-item {% if request.TAB == "home" %}current-tab{% endif %}">
                        主页
                    </div>
                </a>
                <a href="{% url 'user:share' user.id %}">
                    <div class="tab-item {% if request.TAB == "share" %}current-tab{% endif %}">
                        分享
                    </div>
                </a>
                <a href="{% url 'user:topic-collection' user.id %}">
                    <div class="tab-item {% if request.TAB == "collection" %}current-tab{% endif %}">
                        专题收藏
                    </div>
                </a>
                <a href="{% url 'user:ate' user.id %}">
                    <div class="tab-item {% if request.TAB == "ate" %}current-tab{% endif %}">
                        吃过的
                    </div>
                </a>
                <a href="{% url 'user:wta' user.id %}">
                    <div class="tab-item {% if request.TAB == "wta" %}current-tab{% endif %}">
                        想吃的
                    </div>
                </a>
                <a href="{% url 'user:following' user.id %}">
                    <div class="tab-item {% if request.TAB == "following" %}current-tab{% endif %}">
                        关注
                    </div>
                </a>
                <a href="{% url 'user:followers' user.id %}">
                    <div class="tab-item {% if request.TAB == "followers" %}current-tab{% endif %}">
                        粉丝
                    </div>
                </a>
                {% if request.user.id == user.id %}
                <a href="{% url 'user:moments' %}">
                    <div class="tab-item {% if request.TAB == "moments" %}current-tab{% endif %}">
                        吃友圈
                    </div>
                </a>
                <a href="{% url 'user:profile' %}">
                    <div class="tab-item  {% if request.TAB == "profile" %}current-tab{% endif %}">
                        编辑资料
                    </div>
                </a>
                {% endif %}
            </div>
            {% block content %}
            {% endblock content %}
        </div>
    {% include 'user/chat.tpl' %}
    <script src="{% static 'js/vendors.js' %}"></script>
    <script src="{% static 'js/user_base.js' %}"></script>
    <script src="{% static 'js/js.cookie.js' %}"></script>
    <script src="http://apps.bdimg.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="{% static 'js/csrf.js' %}"></script>
    <script src="{% static 'js/chat.js' %}"></script>
    <script type="text/javascript">
        $(function(){
            $("#private").click(function() {
                var userId = $("#follow-btn").attr('data-id');
                openChatBar(userId);
            });
            $("#follow-btn").click(function(event) {
                var that = $(this);
                var id = that.attr('data-id');
                var action = that.attr('data-action');

                $.ajax({
                    url: "{% url 'user:follow' %}",
                    method: "POST",
                    data: {
                        id: id,
                        action: action
                    }
                }).success(function(data) {
                    if(data.status == true) {
                        if (action == 'follow') {
                            that.attr('data-action', 'unfollow');
                            that.text('取消关注');
                        } else {
                            that.attr('data-action', 'follow');
                            that.text('关注');
                        }                     
                    }
                }).error(function(error) {
                    alert("网络异常");
                });
            });
        });
    </script>
    {% block js %}
    {% endblock js %}
</body>
</html>