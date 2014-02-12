/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls.scrollClasses
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.hammerc.controls.buttonClasses.AbstractButtonBase;
	import org.hammerc.controls.core.AbstractUIComponent;
	import org.hammerc.controls.core.OrientationType;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.events.ExtendMouseEvent;
	import org.hammerc.extender.MouseEventExtender;
	import org.hammerc.skin.controls.scrollClasses.AbstractScrollBarSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")]
	
	/**
	 * <code>AbstractScrollBar</code> 类抽象出滚动条组件应有的属性及方法.
	 * @author wizardc
	 */
	public class AbstractScrollBar extends AbstractUIComponent
	{
		/**
		 * 记录组件的方向.
		 */
		protected var _orientation:String;
		
		/**
		 * 记录组件内部用于显示滚动条背景的容器对象.
		 */
		protected var _background:Sprite;
		
		/**
		 * 记录向上或向左的箭头按钮.
		 */
		protected var _upOrLeftButton:AbstractButtonBase;
		
		/**
		 * 记录向下或向右的箭头按钮.
		 */
		protected var _bottomOrRightButton:AbstractButtonBase;
		
		/**
		 * 记录滑块按钮.
		 */
		protected var _sliderButton:AbstractButtonBase;
		
		/**
		 * 记录向上或向左箭头按钮的鼠标事件扩展对象.
		 */
		protected var _upOrLeftMouseExtender:MouseEventExtender;
		
		/**
		 * 记录向下或向右箭头按钮的鼠标事件扩展对象.
		 */
		protected var _bottomOrRightMouseExtender:MouseEventExtender;
		
		/**
		 * 记录滑块按钮的鼠标事件扩展对象.
		 */
		protected var _sliderMouseExtender:MouseEventExtender;
		
		/**
		 * 记录背景的鼠标事件扩展对象.
		 */
		protected var _backgroundMouseExtender:MouseEventExtender;
		
		/**
		 * 记录滑块和两个按钮间的间隔.
		 */
		protected var _gap:Number = 0;
		
		/**
		 * 记录滑块最小的尺寸.
		 */
		protected var _sliderMinSize:Number = 10;
		
		/**
		 * 记录可视区域的尺寸.
		 */
		protected var _viewportSize:Number = 1;
		
		/**
		 * 记录需滚动的对象的尺寸.
		 */
		protected var _contentSize:Number = 1;
		
		/**
		 * 记录最小能滚动到的位置.
		 */
		protected var _minScrollPosition:Number = 0;
		
		/**
		 * 记录当前滚动到的位置.
		 */
		protected var _scrollPosition:Number = 0;
		
		/**
		 * 记录每次滚动的最小尺寸.
		 */
		protected var _stepScrollSize:Number = 1;
		
		/**
		 * 记录滚动时是否四舍五入为整数并校正滑块的位置.
		 */
		protected var _useInteger:Boolean = true;
		
		/**
		 * 记录滑块的尺寸.
		 */
		protected var _sliderSize:Number = 0;
		
		/**
		 * 记录拖动时鼠标按下的位置.
		 */
		protected var _mousePosition:Number = 0;
		
		/**
		 * 记录鼠标按下时滑块的位置.
		 */
		protected var _sliderPosition:Number = 0;
		
		/**
		 * <code>AbstractScroll</code> 类为抽象类, 不能被实例化.
		 * @param orientation 组件的方向.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function AbstractScrollBar(orientation:String, skinClass:Class = null)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractScrollBar);
			_orientation = orientation;
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			_background = new Sprite();
			_background.mouseChildren = false;
			this.addChild(_background);
			//添加三个按钮对象
			_upOrLeftButton = (_skin as AbstractScrollBarSkin).createUpOrLeftButton();
			this.addChild(_upOrLeftButton);
			_bottomOrRightButton = (_skin as AbstractScrollBarSkin).createBottomOrRightButton();
			this.addChild(_bottomOrRightButton);
			_sliderButton = (_skin as AbstractScrollBarSkin).createSliderButton();
			this.addChild(_sliderButton);
			//创建鼠标事件扩展对象
			_upOrLeftMouseExtender = new MouseEventExtender(_upOrLeftButton, 500, true, 500, 100);
			_bottomOrRightMouseExtender = new MouseEventExtender(_bottomOrRightButton, 500, true, 500, 100);
			_sliderMouseExtender = new MouseEventExtender(_sliderButton);
			_backgroundMouseExtender = new MouseEventExtender(_background, 500, true, 500, 100);
			//侦听鼠标事件
			_upOrLeftButton.addEventListener(MouseEvent.MOUSE_DOWN, this.pressHandler);
			_upOrLeftButton.addEventListener(ExtendMouseEvent.ALWAYS_PRESS, this.pressHandler);
			_bottomOrRightButton.addEventListener(MouseEvent.MOUSE_DOWN, this.pressHandler);
			_bottomOrRightButton.addEventListener(ExtendMouseEvent.ALWAYS_PRESS, this.pressHandler);
			_background.addEventListener(MouseEvent.MOUSE_DOWN, this.pressHandler);
			_background.addEventListener(ExtendMouseEvent.ALWAYS_PRESS, this.pressHandler);
			_sliderButton.addEventListener(MouseEvent.MOUSE_DOWN, this.sliderButtonPressHandler);
			_sliderButton.addEventListener(ExtendMouseEvent.PRESS_MOVE, this.sliderButtonMoveHandler);
			_sliderButton.addEventListener(MouseEvent.MOUSE_UP, this.sliderButtonReleaseHandler);
			_sliderButton.addEventListener(ExtendMouseEvent.RELEASE_OUTSIDE, this.sliderButtonReleaseHandler);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractScrollBarSkin;
		}
		
		/**
		 * 设置或获取滑块和两个按钮间的间隔.
		 */
		public function set gap(value:Number):void
		{
			if(_gap != value)
			{
				_gap = value;
				this.updatePosition();
			}
		}
		public function get gap():Number
		{
			return _gap;
		}
		
		/**
		 * 设置或获取滑块最小的尺寸.
		 */
		public function set sliderMinSize(value:Number):void
		{
			if(_sliderMinSize != value)
			{
				_sliderMinSize = value;
				this.updatePosition();
			}
		}
		public function get sliderMinSize():Number
		{
			return _sliderMinSize;
		}
		
		/**
		 * 设置或获取可视区域的尺寸.
		 */
		public function set viewportSize(value:Number):void
		{
			if(_viewportSize != value)
			{
				_viewportSize = value;
				this.updatePosition();
			}
		}
		public function get viewportSize():Number
		{
			return _viewportSize;
		}
		
		/**
		 * 设置或获取需滚动的对象的尺寸.
		 */
		public function set contentSize(value:Number):void
		{
			if(_contentSize != value)
			{
				_contentSize = value;
				if(_scrollPosition > _contentSize - _viewportSize)
				{
					_scrollPosition = _contentSize - _viewportSize;
				}
				this.updatePosition();
			}
		}
		public function get contentSize():Number
		{
			return _contentSize;
		}
		
		/**
		 * 设置或获取最小能滚动到的位置.
		 */
		public function set minScrollPosition(value:Number):void
		{
			if(_minScrollPosition != value)
			{
				_minScrollPosition = value;
				if(_scrollPosition < _minScrollPosition)
				{
					_scrollPosition = _minScrollPosition;
				}
				this.updatePosition();
			}
		}
		public function get minScrollPosition():Number
		{
			return _minScrollPosition;
		}
		
		/**
		 * 设置或获取最大能滚动到的位置.
		 */
		public function set maxScrollPosition(value:Number):void
		{
			this.contentSize = value + _viewportSize;
		}
		public function get maxScrollPosition():Number
		{
			return _contentSize - _viewportSize;
		}
		
		/**
		 * 设置或获取当前滚动到的位置.
		 */
		public function set scrollPosition(value:Number):void
		{
			if(_scrollPosition != value)
			{
				_scrollPosition = value;
				if(_scrollPosition < _minScrollPosition)
				{
					_scrollPosition = _minScrollPosition;
				}
				if(_scrollPosition > (_contentSize - _viewportSize))
				{
					_scrollPosition = (_contentSize - _viewportSize);
				}
				this.updatePosition();
			}
		}
		public function get scrollPosition():Number
		{
			return _scrollPosition;
		}
		
		/**
		 * 设置或获取每次滚动的最小尺寸.
		 */
		public function set stepScrollSize(value:Number):void
		{
			_stepScrollSize = value;
		}
		public function get stepScrollSize():Number
		{
			return _stepScrollSize;
		}
		
		/**
		 * 设置或获取滚动时是否四舍五入为整数并校正滑块的位置.
		 */
		public function set useInteger(value:Boolean):void
		{
			if(_useInteger != value)
			{
				_useInteger = value;
				this.updatePosition();
			}
		}
		public function get useInteger():Boolean
		{
			return _useInteger;
		}
		
		/**
		 * 获取组件内部用于显示滚动条背景的容器对象.
		 */
		hammerc_internal function get background():Sprite
		{
			return _background;
		}
		
		/**
		 * 获取向上或向左的箭头按钮.
		 */
		hammerc_internal function get upOrLeftButton():AbstractButtonBase
		{
			return _upOrLeftButton;
		}
		
		/**
		 * 获取向下或向右的箭头按钮.
		 */
		hammerc_internal function get bottomOrRightButton():AbstractButtonBase
		{
			return _bottomOrRightButton;
		}
		
		/**
		 * 获取滑块按钮.
		 */
		hammerc_internal function get sliderButton():AbstractButtonBase
		{
			return _sliderButton;
		}
		
		/**
		 * 箭头按钮按下事件处理方法.
		 * @param event 对应鼠标事件.
		 */
		protected function pressHandler(event:MouseEvent):void
		{
			if(event.currentTarget == _upOrLeftButton)
			{
				this.orientationButtonPress(true);
			}
			else if(event.currentTarget == _bottomOrRightButton)
			{
				this.orientationButtonPress(false);
			}
			else if(event.currentTarget == _background)
			{
				if(_orientation == OrientationType.HORIZONTAL)
				{
					this.orientationButtonPress(this.mouseX < _sliderButton.x);
				}
				else
				{
					this.orientationButtonPress(this.mouseY < _sliderButton.y);
				}
			}
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		/**
		 * 箭头按钮按下时会调用该方法.
		 * @param upOrLeft 是否点击的是向上或向左的按钮.
		 */
		protected function orientationButtonPress(upOrLeft:Boolean):void
		{
			if(upOrLeft)
			{
				this.scrollPosition -= _stepScrollSize;
			}
			else
			{
				this.scrollPosition += _stepScrollSize;
			}
		}
		
		/**
		 * 滑块按下事件.
		 * @param event 对应鼠标事件.
		 */
		protected function sliderButtonPressHandler(event:MouseEvent):void
		{
			_mousePosition = (_orientation == OrientationType.HORIZONTAL) ? this.mouseX : this.mouseY;
			_sliderPosition = (_orientation == OrientationType.HORIZONTAL) ? _sliderButton.x : _sliderButton.y;
		}
		
		/**
		 * 滑块移动事件.
		 * @param event 对应鼠标事件.
		 */
		protected function sliderButtonMoveHandler(event:ExtendMouseEvent):void
		{
			var move:Number, min:Number, max:Number;
			if(_orientation == OrientationType.HORIZONTAL)
			{
				move = this.mouseX - _mousePosition;
				_sliderButton.x = _sliderPosition + move;
				min = _upOrLeftButton.width + _gap;
				max = this.width - _bottomOrRightButton.width - _gap - _sliderButton.width;
				if(_sliderButton.x < min)
				{
					_sliderButton.x = min;
				}
				if(_sliderButton.x > max)
				{
					_sliderButton.x = max;
				}
			}
			else
			{
				move = this.mouseY - _mousePosition;
				_sliderButton.y = _sliderPosition + move;
				min = _upOrLeftButton.height + _gap;
				max = this.height - _bottomOrRightButton.height - _gap - _sliderButton.height;
				if(_sliderButton.y < min)
				{
					_sliderButton.y = min;
				}
				if(_sliderButton.y > max)
				{
					_sliderButton.y = max;
				}
			}
			this.updateScrollPosition();
			this.dispatchEvent(new Event(Event.CHANGE));
			event.updateAfterEvent();
		}
		
		/**
		 * 滑块释放事件.
		 * @param event 对应鼠标事件.
		 */
		protected function sliderButtonReleaseHandler(event:MouseEvent):void
		{
			_mousePosition = 0;
			_sliderPosition = 0;
			this.updateSliderPosition();
		}
		
		/**
		 * 更新当前的滑块尺寸.
		 */
		protected function updateSliderSize():void
		{
			var sliderRect:Number;
			if(_orientation == OrientationType.HORIZONTAL)
			{
				sliderRect = this.width - _upOrLeftButton.width - _bottomOrRightButton.width - _gap * 2;
			}
			else
			{
				sliderRect = this.height - _upOrLeftButton.height - _bottomOrRightButton.height - _gap * 2;
			}
			var viewportPercent:Number = 1;
			if(_contentSize - _minScrollPosition > _viewportSize)
			{
				viewportPercent = _viewportSize / (_contentSize - _minScrollPosition);
			}
			_sliderSize = sliderRect * viewportPercent;
			if(_sliderSize < _sliderMinSize)
			{
				_sliderSize = _sliderMinSize;
			}
			(_orientation == OrientationType.HORIZONTAL) ? _sliderButton.width = _sliderSize : _sliderButton.height = _sliderSize;
		}
		
		/**
		 * 根据滑块的位置更新滚动的位置.
		 */
		protected function updateScrollPosition():void
		{
			var sliderRect:Number;
			var sliderPosition:Number;
			if(_orientation == OrientationType.HORIZONTAL)
			{
				sliderRect = this.width - _upOrLeftButton.width - _bottomOrRightButton.width - _gap * 2 - _sliderSize;
				sliderPosition = _sliderButton.x - _upOrLeftButton.width - _gap;
			}
			else
			{
				sliderRect = this.height - _upOrLeftButton.height - _bottomOrRightButton.height - _gap * 2 - _sliderSize;
				sliderPosition = _sliderButton.y - _upOrLeftButton.height - _gap;
			}
			var sliderPercent:Number = 0;
			if(sliderRect != 0)
			{
				sliderPercent = sliderPosition / sliderRect;
			}
			var scrollRect:Number = _contentSize - _minScrollPosition - _viewportSize;
			_scrollPosition = scrollRect * sliderPercent + _minScrollPosition;
			if(_useInteger)
			{
				_scrollPosition = Math.round(_scrollPosition);
			}
		}
		
		/**
		 * 根据滚动的位置更新滑块的位置.
		 */
		protected function updateSliderPosition():void
		{
			var scrollPositionPercent:Number;
			if((_contentSize - _minScrollPosition) <= _viewportSize)
			{
				scrollPositionPercent = 0;
			}
			else
			{
				scrollPositionPercent = (_scrollPosition - _minScrollPosition) / (_contentSize - _minScrollPosition - _viewportSize);
			}
			var sliderRect:Number;
			var endPosition:Number;
			if(_orientation == OrientationType.HORIZONTAL)
			{
				sliderRect = this.width - _upOrLeftButton.width - _bottomOrRightButton.width - _gap * 2 - _sliderSize;
				endPosition = _upOrLeftButton.width + _gap + sliderRect * scrollPositionPercent;
				_sliderButton.x = endPosition;
			}
			else
			{
				sliderRect = this.height - _upOrLeftButton.height - _bottomOrRightButton.height - _gap * 2 - _sliderSize;
				endPosition = _upOrLeftButton.height + _gap + sliderRect * scrollPositionPercent;
				_sliderButton.y = endPosition;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function layout():void
		{
			if(_orientation == OrientationType.HORIZONTAL)
			{
				_upOrLeftButton.height = _bottomOrRightButton.height = _sliderButton.height = this.height;
				_upOrLeftButton.x = 0;
				_bottomOrRightButton.x = this.width - _bottomOrRightButton.width;
			}
			else
			{
				_upOrLeftButton.width = _bottomOrRightButton.width = _sliderButton.width = this.width;
				_upOrLeftButton.y = 0;
				_bottomOrRightButton.y = this.height - _bottomOrRightButton.height;
			}
			//更新滑块对象
			this.updatePosition();
		}
		
		/**
		 * 根据滚动信息更新子组件的位置和大小.
		 */
		protected function updatePosition():void
		{
			this.updateSliderSize();
			this.updateSliderPosition();
		}
	}
}
