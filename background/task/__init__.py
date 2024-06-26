# -*- coding: utf-8 -*-
"""
@software: PyCharm
@file: __init__.py.py
@time: 2024/6/5 下午1:39
@author SuperLazyDog
"""
from schema import Task
from .pages.general import pages as general_pages
from .pages.boss import pages as boss_pages
from .pages.dreamless import pages as dreamless_pages
from .conditional_actions.boss import conditional_actions

# 合并所有页面
task = Task()
task.pages = general_pages + boss_pages + dreamless_pages  # 合并通用页面和boss页面
task.conditionalActions = conditional_actions  # 添加boss专属条件动作
