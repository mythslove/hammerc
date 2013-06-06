/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	import org.hammerc.controls.scrollClasses.ScrollPolicy;
	import org.hammerc.controls.supportClasses.Margin;
	import org.hammerc.controls.textClasses.AbstractText;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.controls.AbstractTextAreaSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")]
	
	/**
	 * @eventType flash.events.Event.SCROLL
	 */
	[Event(name="scroll", type="flash.events.Event")]
	
	/**
	 * @eventType flash.events.TextEvent.TEXT_INPUT
	 */
	[Event(name="textInput", type="flash.events.TextEvent")]
	
	/**
	 * @eventType flash.events.Event.TEXT_INTERACTION_MODE_CHANGE
	 */
	[Event(name="textInteractionModeChange", type="flash.events.Event")]
	
	/**
	 * <code>TextArea</code> 类定义多行文本字段.
	 * @author wizardc
	 */
	public class TextArea extends AbstractText
	{
		/**
		 * 记录文本框的外边距对象.
		 */
		protected var _textMargin:Margin;
		
		/**
		 * 记录文本框是否可以编辑.
		 */
		protected var _editable:Boolean = true;
		
		/**
		 * 记录水平滚动条的显示策略.
		 */
		protected var _horizontalScrollPolicy:String = ScrollPolicy.AUTO;
		
		/**
		 * 记录垂直滚动条的显示策略.
		 */
		protected var _verticalScrollPolicy:String = ScrollPolicy.AUTO;
		
		/**
		 * 记录背景显示对象.
		 */
		protected var _background:Sprite;
		
		/**
		 * 记录水平滚动条对象.
		 */
		protected var _horizontalScrollBar:HScrollBar;
		
		/**
		 * 记录垂直滚动条对象.
		 */
		protected var _verticalScrollBar:VScrollBar;
		
		/**
		 * 创建一个 <code>TextArea</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function TextArea(skinClass:Class = null)
		{
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			super.init();
			_textMargin = new Margin();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			//添加背景显示对象
			_background = new Sprite();
			this.addChildAt(_background, 0);
			//添加滚动条对象
			_horizontalScrollBar = (_skin as AbstractTextAreaSkin).createHorizontalScrollBar();
			_horizontalScrollBar.stepScrollSize = 30;
			this.addChild(_horizontalScrollBar);
			_verticalScrollBar = (_skin as AbstractTextAreaSkin).createVerticalScrollBar();
			_verticalScrollBar.minScrollPosition = 1;
			this.addChild(_verticalScrollBar);
			//抛出内部事件
			_textField.addEventListener(Event.CHANGE, this.dispatchEventHandler);
			_textField.addEventListener(Event.SCROLL, this.dispatchEventHandler);
			_textField.addEventListener(TextEvent.TEXT_INPUT, this.dispatchEventHandler);
			_textField.addEventListener(Event.TEXT_INTERACTION_MODE_CHANGE, this.dispatchEventHandler);
			//侦听内部事件
			_textField.addEventListener(Event.CHANGE, this.textFieldChangeHandler);
			_textField.addEventListener(Event.SCROLL, this.textFieldScrollHandler);
			_horizontalScrollBar.addEventListener(Event.CHANGE, this.scrollBarChangeHandler);
			_verticalScrollBar.addEventListener(Event.CHANGE, this.scrollBarChangeHandler);
			//设置默认属性
			_textField.alwaysShowSelection = false;
			_textField.autoSize = TextFieldAutoSize.NONE;
			_textField.displayAsPassword = false;
			_textField.maxChars = 0;
			_textField.multiline = true;
			_textField.restrict = null;
			_textField.selectable = true;
			_textField.type = TextFieldType.INPUT;
			_textField.wordWrap = false;
			//设置文本样式
			this.setTextFormat();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractTextAreaSkin;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createDefaultSkin():ISkin
		{
			return SkinManager.getInstance().defaultTheme.getDefaultSkin(this);
		}
		
		/**
		 * 设置或获取文本字段没有焦点时是否以灰色突出显示文本字段中的所选内容.
		 */
		public function set alwaysShowSelection(value:Boolean):void
		{
			_textField.alwaysShowSelection = value;
		}
		public function get alwaysShowSelection():Boolean
		{
			return _textField.alwaysShowSelection;
		}
		
		/**
		 * 获取插入点位置的索引.
		 */
		public function get caretIndex():int
		{
			return _textField.caretIndex;
		}
		
		/**
		 * 设置或获取文本字段是否是密码文本字段.
		 */
		public function set displayAsPassword(value:Boolean):void
		{
			if(this.displayAsPassword != value)
			{
				_textField.displayAsPassword = value;
				this.setTextFormat();
			}
		}
		public function get displayAsPassword():Boolean
		{
			return _textField.displayAsPassword;
		}
		
		/**
		 * 设置或获取文本框是否可以编辑.
		 */
		public function set editable(value:Boolean):void
		{
			if(_editable != value)
			{
				_editable = value;
				_textField.type = _editable ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
			}
		}
		public function get editable():Boolean
		{
			return _editable;
		}
		
		/**
		 * 设置或获取文本字段中最多可包含的字符数.
		 */
		public function set maxChars(value:int):void
		{
			_textField.maxChars = value;
		}
		public function get maxChars():int
		{
			return _textField.maxChars;
		}
		
		/**
		 * 设置或获取表示用户可输入到文本字段中的字符集.
		 */
		public function set restrict(value:String):void
		{
			_textField.restrict = value;
		}
		public function get restrict():String
		{
			return _textField.restrict;
		}
		
		/**
		 * 设置或获取文本框的外边距对象.
		 */
		public function set textMargin(value:Margin):void
		{
			_textMargin = value == null ? new Margin() : value.clone();
			this.invalidateLayout();
		}
		public function get textMargin():Margin
		{
			return _textMargin;
		}
		
		/**
		 * 设置或获取文本字段是否自动换行.
		 */
		public function set wordWrap(value:Boolean):void
		{
			_textField.wordWrap = value;
			this.invalidateLayout();
		}
		public function get wordWrap():Boolean
		{
			return _textField.wordWrap;
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
		 * 设置或获取水平滚动条的当前滚动到的位置.
		 */
		public function set horizontalScrollPosition(value:Number):void
		{
			_horizontalScrollBar.scrollPosition = value;
		}
		public function get horizontalScrollPosition():Number
		{
			return _horizontalScrollBar.scrollPosition;
		}
		
		/**
		 * 获取水平滚动条的最大能滚动到的位置.
		 */
		public function get horizontalMaxScrollPosition():Number
		{
			return _horizontalScrollBar.maxScrollPosition;
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
		 * 设置或获取垂直滚动条的当前滚动到的位置.
		 */
		public function set verticalScrollPosition(value:Number):void
		{
			_verticalScrollBar.scrollPosition = value;
		}
		public function get verticalScrollPosition():Number
		{
			return _verticalScrollBar.scrollPosition;
		}
		
		/**
		 * 获取垂直滚动条的最大能滚动到的位置.
		 */
		public function get verticalMaxScrollPosition():Number
		{
			return _verticalScrollBar.maxScrollPosition;
		}
		
		/**
		 * 获取背景显示对象.
		 */
		hammerc_internal function get background():Sprite
		{
			return _background;
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
		 * @inheritDoc
		 */
		override protected function setTextFormat():void
		{
			super.setTextFormat();
			_textField.defaultTextFormat = _textFormat;
		}
		
		/**
		 * 文本框文本改变时会调用该处理方法.
		 * @param event 对应的事件对象.
		 */
		protected function textFieldChangeHandler(event:Event):void
		{
			this.invalidateLayout();
		}
		
		/**
		 * 文本框文本滚动时会调用该处理方法.
		 * @param event 对应的事件对象.
		 */
		protected function textFieldScrollHandler(event:Event):void
		{
			if(_verticalScrollPolicy == ScrollPolicy.ON || (_verticalScrollPolicy == ScrollPolicy.AUTO && _textField.maxScrollV > 1))
			{
				_verticalScrollBar.scrollPosition = _textField.scrollV;
			}
			if(_horizontalScrollPolicy == ScrollPolicy.ON || (_horizontalScrollPolicy == ScrollPolicy.AUTO && _textField.maxScrollH > 0))
			{
				_horizontalScrollBar.scrollPosition = _textField.scrollH;
			}
		}
		
		/**
		 * 滚动条改变时会调用该处理方法.
		 * @param event 对应的事件对象.
		 */
		protected function scrollBarChangeHandler(event:Event):void
		{
			if(event.currentTarget == _horizontalScrollBar)
			{
				_textField.scrollH = _horizontalScrollBar.scrollPosition;
			}
			else if(event.currentTarget == _verticalScrollBar)
			{
				_textField.scrollV = _verticalScrollBar.scrollPosition;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function layout():void
		{
			//先假设两个滚动条都不显示时, 取得的文本框大小
			var textWidth:Number = _width - _textMargin.left - _textMargin.right;
			var textHeight:Number = _height - _textMargin.top - _textMargin.bottom;
			_textField.visible = (textWidth > 0 && textHeight > 0);
			_textField.x = _textMargin.left;
			_textField.y = _textMargin.top;
			_textField.width = textWidth;
			_textField.height = textHeight;
			//文本框不显示时隐藏滚动条并退出方法
			if(textWidth <= 0 || textHeight <= 0)
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
				if(_textField.maxScrollV > 1)
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
					//添加了垂直滚动条后无法显示文本时就什么都不显示并退出方法
					if(_textField.width - _verticalScrollBar.width <= 0)
					{
						_textField.visible = _horizontalScrollBar.visible = _verticalScrollBar.visible = false;
						return;
					}
					//减小文本区域宽度
					_textField.width -= _verticalScrollBar.width;
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
					showHorizontalScrollBar = _textField.maxScrollH > 0;
				}
				//设置水平滚动条是否显示
				if(showHorizontalScrollBar)
				{
					//添加了水平滚动条后无法显示文本时就什么都不显示并退出方法
					if(_textField.height - _horizontalScrollBar.height <= 0)
					{
						_textField.visible = _horizontalScrollBar.visible = _verticalScrollBar.visible = false;
						return;
					}
					//减小文本区域高度
					_textField.height -= _horizontalScrollBar.height;
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
					showHorizontalScrollBar = _textField.maxScrollH > 0;
				}
				//设置水平滚动条是否显示
				if(showHorizontalScrollBar)
				{
					//添加了水平滚动条后无法显示文本时就什么都不显示并退出方法
					if(_textField.height - _horizontalScrollBar.height <= 0)
					{
						_textField.visible = _horizontalScrollBar.visible = _verticalScrollBar.visible = false;
						return;
					}
					//减小文本区域高度
					_textField.height -= _horizontalScrollBar.height;
					//再次判断垂直滚动条是否需要显示
					showVerticalScrollBar = _textField.maxScrollV > 1;
					//设置垂直滚动条是否显示
					if(showVerticalScrollBar)
					{
						//添加了垂直滚动条后无法显示文本时就什么都不显示并退出方法
						if(_textField.width - _verticalScrollBar.width <= 0)
						{
							_textField.visible = _horizontalScrollBar.visible = _verticalScrollBar.visible = false;
							return;
						}
						//减小文本区域宽度
						_textField.width -= _verticalScrollBar.width;
					}
				}
			}
			//调整滚动条的位置及尺寸
			_horizontalScrollBar.visible = showHorizontalScrollBar;
			_verticalScrollBar.visible = showVerticalScrollBar;
			if(showHorizontalScrollBar)
			{
				_horizontalScrollBar.x = _textField.x;
				_horizontalScrollBar.y = _textField.y + _textField.height;
				_horizontalScrollBar.width = _textField.width;
			}
			if(showVerticalScrollBar)
			{
				_verticalScrollBar.x = _textField.x + _textField.width;
				_verticalScrollBar.y = _textField.y;
				_verticalScrollBar.height = _textField.height;
			}
			//设定滚动区域
			_horizontalScrollBar.enabled = showHorizontalScrollBar;
			_horizontalScrollBar.viewportSize = showHorizontalScrollBar ? _textField.width : 1;
			_horizontalScrollBar.maxScrollPosition = showHorizontalScrollBar ? _textField.maxScrollH : 0;
			_horizontalScrollBar.scrollPosition = showHorizontalScrollBar ? _textField.scrollH : 0;
			_verticalScrollBar.enabled = showVerticalScrollBar;
			_verticalScrollBar.viewportSize = showVerticalScrollBar ? _textField.bottomScrollV - _textField.scrollV : 1;
			_verticalScrollBar.maxScrollPosition = showVerticalScrollBar ? _textField.maxScrollV : 1;
			_verticalScrollBar.scrollPosition = showVerticalScrollBar ? _textField.scrollV : 1;
		}
	}
}
