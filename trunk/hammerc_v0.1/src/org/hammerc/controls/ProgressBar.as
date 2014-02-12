/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls
{
	import flash.events.Event;
	import flash.display.Sprite;
	
	import org.hammerc.controls.core.AbstractUIComponent;
	import org.hammerc.controls.core.OrientationType;
	import org.hammerc.controls.supportClasses.Margin;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.controls.AbstractProgressBarSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")]
	
	/**
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * <code>ProgressBar</code> 类定义可滚动的进度条. 滚动条组件默认不参与鼠标交互.
	 * @author wizardc
	 */
	public class ProgressBar extends AbstractUIComponent
	{
		/**
		 * 记录滚动条的方向.
		 */
		protected var _orientation:String;
		
		/**
		 * 记录当前滚动条的值.
		 */
		protected var _value:Number = 0;
		
		/**
		 * 记录滚动条最小能接受的值.
		 */
		protected var _mininum:Number = 0;
		
		/**
		 * 记录滚动条最大能接受的值.
		 */
		protected var _maxinum:Number = 1;
		
		/**
		 * 记录组件内部用于显示背景的容器对象.
		 */
		protected var _background:Sprite;
		
		/**
		 * 记录组件内部用于显示填充滚动条的容器对象.
		 */
		protected var _fillBar:Sprite;
		
		/**
		 * 记录内部进度条的外边距对象.
		 */
		protected var _fillBarMargin:Margin;
		
		/**
		 * 创建一个 <code>ProgressBar</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function ProgressBar(skinClass:Class = null)
		{
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			_background = new Sprite();
			_background.mouseEnabled = _background.mouseChildren = false;
			this.addChild(_background);
			_fillBar = new Sprite();
			_fillBar.mouseEnabled = _fillBar.mouseChildren = false;
			this.addChild(_fillBar);
			//设置默认属性
			this.mouseEnabled = this.mouseChildren = false;
			_orientation = OrientationType.HORIZONTAL;
			_fillBarMargin = new Margin();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractProgressBarSkin;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createDefaultSkin():ISkin
		{
			return SkinManager.getInstance().defaultTheme.getDefaultSkin(this);
		}
		
		/**
		 * 设置或获取滚动条的方向.
		 */
		public function set orientation(value:String):void
		{
			if(_orientation != value)
			{
				_orientation = value;
				(_skin as AbstractProgressBarSkin).fillBarChange();
			}
		}
		public function get orientation():String
		{
			return _orientation;
		}
		
		/**
		 * 设置或获取当前滚动条的值.
		 */
		public function set value(value:Number):void
		{
			value = value < _mininum ? _mininum : (value > _maxinum ? _maxinum : value);
			if(_value != value)
			{
				_value = value;
				(_skin as AbstractProgressBarSkin).onValueChanged(_value);
				this.dispatchEvent(new Event(Event.CHANGE));
				if(_value == _maxinum)
				{
					this.dispatchEvent(new Event(Event.COMPLETE));
				}
			}
		}
		public function get value():Number
		{
			return _value;
		}
		
		/**
		 * 设置或获取滚动条最小能接受的值.
		 */
		public function set mininum(value:Number):void
		{
			if(_mininum != value)
			{
				_mininum = value;
				_value = _value < _mininum ? _mininum : _value;
				(_skin as AbstractProgressBarSkin).fillBarChange();
			}
		}
		public function get mininum():Number
		{
			return _mininum;
		}
		
		/**
		 * 设置或获取滚动条最大能接受的值.
		 */
		public function set maxinum(value:Number):void
		{
			if(_maxinum != value)
			{
				_maxinum = value;
				_value = _value > _maxinum ? _maxinum : _value;
				(_skin as AbstractProgressBarSkin).fillBarChange();
			}
		}
		public function get maxinum():Number
		{
			return _maxinum;
		}
		
		/**
		 * 设置或获取内部进度条的外边距对象.
		 */
		public function set fillBarMargin(value:Margin):void
		{
			_fillBarMargin = value == null ? new Margin() : value.clone();
			(_skin as AbstractProgressBarSkin).fillBarChange();
			this.invalidateLayout();
		}
		public function get fillBarMargin():Margin
		{
			return _fillBarMargin;
		}
		
		/**
		 * 获取组件内部用于显示背景的容器对象.
		 */
		hammerc_internal function get background():Sprite
		{
			return _background;
		}
		
		/**
		 * 获取组件内部用于显示填充滚动条的容器对象.
		 */
		hammerc_internal function get fillBar():Sprite
		{
			return _fillBar;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onSizeChanged(width:Number, height:Number):void
		{
			(_skin as AbstractProgressBarSkin).fillBarChange();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function layout():void
		{
			_fillBar.x = _fillBarMargin.left;
			_fillBar.y = _fillBarMargin.top;
		}
	}
}
