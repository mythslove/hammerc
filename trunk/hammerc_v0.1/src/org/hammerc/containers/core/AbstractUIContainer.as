/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.containers.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.hammerc.controls.core.AbstractUIComponent;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.controls.supportClasses.Margin;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.skin.containers.core.AbstractUIContainerSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * @eventType flash.events.Event.SCROLL
	 */
	[Event(name="scroll", type="flash.events.Event")]
	
	/**
	 * <code>AbstractUIContainer</code> 类为所有容器的基类, 定义了容器的基本属性及方法.
	 * @author wizardc
	 */
	public class AbstractUIContainer extends AbstractUIComponent implements IUIContainer
	{
		/**
		 * 记录容器内部所有添加的元素.
		 */
		protected var _elementsList:Vector.<IUIComponent>;
		
		/**
		 * 记录内部容器对象的外边距对象.
		 */
		protected var _contentMargin:Margin;
		
		/**
		 * 记录容器内部的背景容器对象.
		 */
		protected var _background:Sprite;
		
		/**
		 * 记录内部容器对象可视区域的实际宽度.
		 */
		protected var _viewportWidth:Number;
		
		/**
		 * 记录内部容器对象可视区域的实际高度.
		 */
		protected var _viewportHeight:Number;
		
		/**
		 * 记录实际添加子对象的容器对象.
		 */
		protected var _content:Sprite;
		
		/**
		 * 记录内部容器的实际宽度.
		 */
		protected var _contentWidth:Number = 0;
		
		/**
		 * 记录内部容器的实际高度.
		 */
		protected var _contentHeight:Number = 0;
		
		/**
		 * 记录水平滚动条的当前位置.
		 */
		protected var _horizontalScrollPosition:Number = 0;
		
		/**
		 * 记录水平滚动条的最大能到达的位置.
		 */
		protected var _maxHorizontalScrollPosition:Number = 0;
		
		/**
		 * 记录垂直滚动条的当前位置.
		 */
		protected var _verticalScrollPosition:Number = 0;
		
		/**
		 * 记录垂直滚动条的最大能到达的位置.
		 */
		protected var _maxVerticalScrollPosition:Number = 0;
		
		/**
		 * <code>AbstractUIComponent</code> 类为抽象类, 不能被实例化.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function AbstractUIContainer(skinClass:Class = null)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractUIContainer);
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			_elementsList = new Vector.<IUIComponent>();
			_contentMargin = new Margin();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			_background = new Sprite();
			_background.mouseChildren = _background.mouseEnabled = false;
			this.addChild(_background);
			_content = new Sprite();
			_content.scrollRect = new Rectangle();
			this.addChild(_content);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractUIContainerSkin;
		}
		
		/**
		 * 设置或获取文本框的外边距对象.
		 */
		public function set contentMargin(value:Margin):void
		{
			_contentMargin = value == null ? new Margin() : value.clone();
			this.invalidateLayout();
		}
		public function get contentMargin():Margin
		{
			return _contentMargin;
		}
		
		/**
		 * 设置或获取水平滚动条的当前位置.
		 */
		public function set horizontalScrollPosition(value:Number):void
		{
			value = (value < 0) ? 0 : (value > _maxHorizontalScrollPosition ? _maxHorizontalScrollPosition: value);
			if(_horizontalScrollPosition != value)
			{
				_horizontalScrollPosition = value;
				this.updateScrollRect();
				this.dispatchEvent(new Event(Event.SCROLL));
			}
		}
		public function get horizontalScrollPosition():Number
		{
			return _horizontalScrollPosition;
		}
		
		/**
		 * 获取水平滚动条的最大能到达的位置.
		 */
		public function get maxHorizontalScrollPosition():Number
		{
			return _maxHorizontalScrollPosition;
		}
		
		/**
		 * 设置或获取垂直滚动条的当前位置.
		 */
		public function set verticalScrollPosition(value:Number):void
		{
			value = (value < 0) ? 0 : (value > _maxVerticalScrollPosition ? _maxVerticalScrollPosition: value);
			if(_verticalScrollPosition != value)
			{
				_verticalScrollPosition = value;
				this.updateScrollRect();
				this.dispatchEvent(new Event(Event.SCROLL));
			}
		}
		public function get verticalScrollPosition():Number
		{
			return _verticalScrollPosition;
		}
		
		/**
		 * 获取垂直滚动条的最大能到达的位置.
		 */
		public function get maxVerticalScrollPosition():Number
		{
			return _maxVerticalScrollPosition;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get numElements():int
		{
			return _elementsList.length;
		}
		
		/**
		 * 获取容器内部的背景容器对象.
		 */
		hammerc_internal function get background():Sprite
		{
			return _background;
		}
		
		/**
		 * 获取容器内部的实际添加子对象的容器对象.
		 */
		hammerc_internal function get content():Sprite
		{
			return _content;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function layout():void
		{
			this.collocateElements();
			this.calculateSize();
			this.updateScrollRect();
		}
		
		/**
		 * 排列布局容器内部的所有元素.
		 */
		protected function collocateElements():void
		{
		}
		
		/**
		 * 根据容器内部的组件计算容器的尺寸.
		 */
		protected function calculateSize():void
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
			//获取容器可视区域的尺寸
			_viewportWidth = width - _contentMargin.left - _contentMargin.right;
			_viewportHeight = height - _contentMargin.top - _contentMargin.bottom;
			_content.x = _contentMargin.left;
			_content.y = _contentMargin.top;
			//获取最大可滚动到的位置
			_maxHorizontalScrollPosition = Math.max(_contentWidth - _viewportWidth, 0);
			_maxVerticalScrollPosition = Math.max(_contentHeight - _viewportHeight, 0);
			//校正当前的滚动位置
			var oldHorizontalScrollPosition:Number = _horizontalScrollPosition;
			var oldVerticalScrollPosition:Number = _verticalScrollPosition;
			_horizontalScrollPosition = Math.min(_horizontalScrollPosition, _maxHorizontalScrollPosition);
			_verticalScrollPosition = Math.min(_verticalScrollPosition, _maxVerticalScrollPosition);
			if(_horizontalScrollPosition != oldHorizontalScrollPosition || _verticalScrollPosition != oldVerticalScrollPosition)
			{
				this.dispatchEvent(new Event(Event.SCROLL));
			}
		}
		
		/**
		 * 更新滚动区域.
		 */
		protected function updateScrollRect():void
		{
			var rect:Rectangle = _content.scrollRect;
			rect.setTo(_horizontalScrollPosition, _verticalScrollPosition, _viewportWidth, _viewportHeight);
			_content.scrollRect = rect;
		}
		
		/**
		 * 检测索引是否超出可视区域的范围.
		 * @param index 需要检测的索引.
		 * @param addingElement 是否用于元素添加时的检测.
		 * @throws RangeError 检测的索引超出可视区域的范围时抛出该异常.
		 */
		protected function checkForRangeError(index:int, addingElement:Boolean = false):void
		{
			var maxIndex:int = _elementsList.length - 1;
			if(addingElement)
			{
				maxIndex++;
			}
			if(index < 0 || index > maxIndex)
			{
				throw new RangeError("索引\"" + index + "\"超出可视区域的范围！");
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function addElement(element:IUIComponent):IUIComponent
		{
			var index:int = numElements;
			if(element.parentContainer == this)
			{
				index--;
			}
			return addElementAt(element, index);
		}
		
		/**
		 * @inheritDoc
		 */
		public function addElementAt(element:IUIComponent, index:int):IUIComponent
		{
			if(element == this)
			{
				return element;
			}
			this.checkForRangeError(index, true);
			var parentContainer:IUIContainer = element.parentContainer;
			if(parentContainer == this)
			{
				this.setElementIndex(element, index);
				return element;
			}
			else if(parentContainer != null)
			{
				parentContainer.removeElement(element);
			}
			_elementsList.splice(index, 0, element);
			_content.addChild(element as DisplayObject);
			this.invalidateLayout();
			return element;
		}
		
		/**
		 * @inheritDoc
		 */
		public function containsElement(element:IUIComponent):Boolean
		{
			return _elementsList.indexOf(element) != -1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getElementAt(index:int):IUIComponent
		{
			this.checkForRangeError(index);
			return _elementsList[index];
		}
		
		/**
		 * @inheritDoc
		 */
		public function getElementByName(name:String):IUIComponent
		{
			for each(var element:IUIComponent in _elementsList)
			{
				if((element as DisplayObject).name == name)
				{
					return element;
				}
			}
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getElementIndex(element:IUIComponent):int
		{
			return _elementsList.indexOf(element);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeElement(element:IUIComponent):IUIComponent
		{
			return this.removeElementAt(this.getElementIndex(element));
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeElementAt(index:int):IUIComponent
		{
			this.checkForRangeError(index);
			_elementsList.splice(index, 1);
			var element:IUIComponent = _elementsList[index];
			_content.removeChild(element as DisplayObject);
			this.invalidateLayout();
			return element;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeElements(beginIndex:int = 0, endIndex:int = 0x7fffffff):void
		{
			beginIndex = beginIndex < 0 ? 0 : beginIndex;
			endIndex = endIndex > this.numElements ? this.numElements : endIndex;
			for(var i:int = endIndex - 1; i >= beginIndex ; i--)
			{
				this.removeElementAt(i);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function setElementIndex(element:IUIComponent, index:int):void
		{
			this.checkForRangeError(index);
			var oldIndex:int = this.getElementIndex(element);
			if(oldIndex == -1 || oldIndex == index)
			{
				return;
			}
			_elementsList.splice(oldIndex, 1);
			_elementsList.splice(index, 0, element);
			_content.setChildIndex(element as DisplayObject, index);
		}
		
		/**
		 * @inheritDoc
		 */
		public function swapElements(element1:IUIComponent, element2:IUIComponent):void
		{
			this.swapElementsAt(this.getElementIndex(element1), this.getElementIndex(element2));
		}
		
		/**
		 * @inheritDoc
		 */
		public function swapElementsAt(index1:int, index2:int):void
		{
			this.checkForRangeError(index1);
			this.checkForRangeError(index2);
			if(index1 > index2)
			{
				var temp:int = index1;
				index1 = index2;
				index2 = temp;
			}
			else if(index1 == index2)
			{
				return;
			}
			var element1:IUIComponent = _elementsList[index1];
			var element2:IUIComponent = _elementsList[index2];
			_elementsList.splice(index2, 1);
			_elementsList.splice(index1, 1);
			_elementsList.splice(index1, 0, element2);
			_elementsList.splice(index2, 0, element1);
			_content.swapChildrenAt(index1, index2);
		}
	}
}
