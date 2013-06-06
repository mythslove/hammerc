/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.containers.scrollerClasses
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import org.hammerc.containers.core.AbstractUIContainer;
	import org.hammerc.controls.HScrollBar;
	import org.hammerc.controls.VScrollBar;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.controls.scrollClasses.ScrollPolicy;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.skin.containers.scrollerClasses.AbstractScrollerSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractScroller</code> 类抽象出带有滚动条的容器应用的属性及方法.
	 * @author wizardc
	 */
	public class AbstractScroller extends AbstractUIContainer
	{
		/**
		 * 记录水平滚动条的显示策略.
		 */
		protected var _horizontalScrollPolicy:String = ScrollPolicy.AUTO;
		
		/**
		 * 记录垂直滚动条的显示策略.
		 */
		protected var _verticalScrollPolicy:String = ScrollPolicy.AUTO;
		
		/**
		 * 记录水平滚动条对象.
		 */
		protected var _horizontalScrollBar:HScrollBar;
		
		/**
		 * 记录垂直滚动条对象.
		 */
		protected var _verticalScrollBar:VScrollBar;
		
		/**
		 * 创建一个 <code>AbstractScroller</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function AbstractScroller(skinClass:Class = null)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractScroller);
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			//添加滚动条对象
			_horizontalScrollBar = (_skin as AbstractScrollerSkin).createHorizontalScrollBar();
			_horizontalScrollBar.stepScrollSize = 30;
			this.addChild(_horizontalScrollBar);
			_verticalScrollBar = (_skin as AbstractScrollerSkin).createVerticalScrollBar();
			_verticalScrollBar.stepScrollSize = 30;
			this.addChild(_verticalScrollBar);
			//侦听内部事件
			_horizontalScrollBar.addEventListener(Event.CHANGE, this.scrollBarChangeHandler);
			_verticalScrollBar.addEventListener(Event.CHANGE, this.scrollBarChangeHandler);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractScrollerSkin;
		}
		
		/**
		 * 设置或获取水平滚动条的显示策略.
		 */
		public function set horizontalScrollPolicy(value:String):void
		{
			if(_horizontalScrollPolicy != value)
			{
				_horizontalScrollPolicy = value;
				this.invalidateLayout();
			}
		}
		public function get horizontalScrollPolicy():String
		{
			return _horizontalScrollPolicy;
		}
		
		/**
		 * 设置或获取垂直滚动条的显示策略.
		 */
		public function set verticalScrollPolicy(value:String):void
		{
			if(_verticalScrollPolicy != value)
			{
				_verticalScrollPolicy = value;
				this.invalidateLayout();
			}
		}
		public function get verticalScrollPolicy():String
		{
			return _verticalScrollPolicy;
		}
		
		/**
		 * 获取水平滚动条对象.
		 */
		hammerc_internal function get horizontalScrollBar():HScrollBar
		{
			return _horizontalScrollBar;
		}
		
		/**
		 * 获取垂直滚动条对象.
		 */
		hammerc_internal function get verticalScrollBar():VScrollBar
		{
			return _verticalScrollBar;
		}
		
		/**
		 * 滚动条改变时会调用该处理方法.
		 * @param event 对应的事件对象.
		 */
		protected function scrollBarChangeHandler(event:Event):void
		{
			if(event.currentTarget == _horizontalScrollBar)
			{
				this.horizontalScrollPosition = _horizontalScrollBar.scrollPosition;
			}
			else if(event.currentTarget == _verticalScrollBar)
			{
				this.verticalScrollPosition = _verticalScrollBar.scrollPosition;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function calculateSize():void
		{
			//获取容器内部的尺寸
			_contentWidth = _contentHeight = 0;
			for each(var element:IUIComponent in _elementsList)
			{
				var displayObject:DisplayObject = element as DisplayObject;
				var maxWidth:Number = displayObject.x + displayObject.width;
				var maxHeight:Number = displayObject.y + displayObject.height;
				if(_contentWidth < maxWidth)
				{
					_contentWidth = maxWidth;
				}
				if(_contentHeight < maxHeight)
				{
					_contentHeight = maxHeight;
				}
			}
			//先假设两个滚动条都不显示时, 取得的容器可视区域的尺寸
			_viewportWidth = width - _contentMargin.left - _contentMargin.right;
			_viewportHeight = height - _contentMargin.top - _contentMargin.bottom;
			_content.x = _contentMargin.left;
			_content.y = _contentMargin.top;
			//容器不显示时隐藏滚动条并退出方法
			if(_viewportWidth <= 0 || _viewportHeight <= 0)
			{
				_horizontalScrollBar.visible = _verticalScrollBar.visible = false;
				return;
			}
			//记录最终是否要显示水平或垂直滚动条
			var showHorizontalScrollBar:Boolean;
			var showVerticalScrollBar:Boolean;
			//记录垂直滚动条是否已经确定其一定会出现还是一定不会出现
			var makeSureShowOrHideVerticalScrollBar:Boolean = true;
			//先判断垂直滚动条是否显示
			if(_verticalScrollPolicy == ScrollPolicy.ON)
			{
				showVerticalScrollBar = true;
			}
			else if(_verticalScrollPolicy == ScrollPolicy.OFF)
			{
				showVerticalScrollBar = false;
			}
			else
			{
				//内容已经超出范围, 垂直滚动条必须出现
				if(_contentHeight > _viewportHeight)
				{
					showVerticalScrollBar = true;
				}
				//内容未超出范围, 但是不清楚是否显示水平滚动条所以无法确定垂直滚动条是否会出现
				else
				{
					makeSureShowOrHideVerticalScrollBar = false;
				}
			}
			//已经确定垂直滚动条是否出现时
			if(makeSureShowOrHideVerticalScrollBar)
			{
				//设置垂直滚动条是否显示
				if(showVerticalScrollBar)
				{
					//添加了垂直滚动条后无法显示时就什么都不显示并退出方法
					if(_viewportWidth - _verticalScrollBar.width <= 0)
					{
						_content.visible = _horizontalScrollBar.visible = _verticalScrollBar.visible = false;
						return;
					}
					//减小可视区域宽度
					_viewportWidth -= _verticalScrollBar.width;
				}
				//判断水平滚动条是否显示
				if(_horizontalScrollPolicy == ScrollPolicy.ON)
				{
					showHorizontalScrollBar = true;
				}
				else if(_horizontalScrollPolicy == ScrollPolicy.OFF)
				{
					showHorizontalScrollBar = false;
				}
				else
				{
					showHorizontalScrollBar = _contentWidth > _viewportWidth;
				}
				//设置水平滚动条是否显示
				if(showHorizontalScrollBar)
				{
					//添加了水平滚动条后无法显示时就什么都不显示并退出方法
					if(_viewportHeight - _horizontalScrollBar.height <= 0)
					{
						_content.visible = _horizontalScrollBar.visible = _verticalScrollBar.visible = false;
						return;
					}
					//减小可视区域高度
					_viewportHeight -= _horizontalScrollBar.height;
				}
			}
			//未确定垂直滚动条是否出现时
			else
			{
				//判断水平滚动条是否显示
				if(_horizontalScrollPolicy == ScrollPolicy.ON)
				{
					showHorizontalScrollBar = true;
				}
				else if(_horizontalScrollPolicy == ScrollPolicy.OFF)
				{
					showHorizontalScrollBar = false;
				}
				else
				{
					showHorizontalScrollBar = _contentWidth > _viewportWidth;
				}
				//设置水平滚动条是否显示
				if(showHorizontalScrollBar)
				{
					//添加了水平滚动条后无法显示时就什么都不显示并退出方法
					if(_viewportHeight - _horizontalScrollBar.height <= 0)
					{
						_content.visible = _horizontalScrollBar.visible = _verticalScrollBar.visible = false;
						return;
					}
					//减小可视区域高度
					_viewportHeight -= _horizontalScrollBar.height;
					//再次判断垂直滚动条是否需要显示
					showVerticalScrollBar = _contentHeight > _viewportHeight;
					//设置垂直滚动条是否显示
					if(showVerticalScrollBar)
					{
						//添加了垂直滚动条后无法显示时就什么都不显示并退出方法
						if(_viewportWidth - _verticalScrollBar.width <= 0)
						{
							_content.visible = _horizontalScrollBar.visible = _verticalScrollBar.visible = false;
							return;
						}
						//减小可视区域宽度
						_viewportWidth -= _verticalScrollBar.width;
					}
				}
			}
			//获取最大可滚动到的位置
			_maxHorizontalScrollPosition = Math.max(_contentWidth - _viewportWidth, 0);
			_maxVerticalScrollPosition = Math.max(_contentHeight - _viewportHeight, 0);
			//调整滚动条的位置及尺寸
			_horizontalScrollBar.visible = showHorizontalScrollBar;
			_verticalScrollBar.visible = showVerticalScrollBar;
			if(showHorizontalScrollBar)
			{
				_horizontalScrollBar.x = _content.x;
				_horizontalScrollBar.y = _content.y + _viewportHeight;
				_horizontalScrollBar.width = _viewportWidth;
			}
			if(showVerticalScrollBar)
			{
				_verticalScrollBar.x = _content.x + _viewportWidth;
				_verticalScrollBar.y = _content.y;
				_verticalScrollBar.height = _viewportHeight;
			}
			//设定滚动区域
			_horizontalScrollBar.enabled = showHorizontalScrollBar;
			_horizontalScrollBar.viewportSize = showHorizontalScrollBar ? _viewportWidth : 1;
			_horizontalScrollBar.contentSize = showHorizontalScrollBar ? _contentWidth : 1;
			_horizontalScrollBar.scrollPosition = showHorizontalScrollBar ? _horizontalScrollPosition : 0;
			_verticalScrollBar.enabled = showVerticalScrollBar;
			_verticalScrollBar.viewportSize = showVerticalScrollBar ? _viewportHeight : 1;
			_verticalScrollBar.contentSize = showVerticalScrollBar ? _contentHeight : 1;
			_verticalScrollBar.scrollPosition = showVerticalScrollBar ? _verticalScrollPosition : 0;
		}
	}
}
