from django.core.urlresolvers import reverse
from django.db import models

from food.models import Food
from taggit.managers import TaggableManager
from user.models import User

# Create your models here.
class FoodTopic(models.Model):
    title = models.CharField(max_length=32, verbose_name='专题名称')
    users_like = models.ManyToManyField(User, related_name='topics_liked', blank=True, verbose_name='点赞用户')
    users_collect = models.ManyToManyField(User, related_name='topics_collected', blank=True, verbose_name='收藏的用户')
    foods = models.ManyToManyField(Food, verbose_name='美食') 
    tags = TaggableManager(blank=True, help_text='多个标签以逗号分隔', verbose_name="标签")

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('topic:detail', args=[self.id])

    class Meta:
        verbose_name = '美食专题'
        verbose_name_plural = '美食专题'
