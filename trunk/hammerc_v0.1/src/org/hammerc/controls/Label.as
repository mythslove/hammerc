/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls
{
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextFieldAutoSize;
	
	import org.hammerc.controls.textClasses.AbstractText;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.controls.AbstractLabelSkin;
	
	/**
	 * @eventType flash.events.TextEvent.LINK
	 */
	[Event(name="link", type="flash.events.TextEvent")]
	
	/**
	 * @eventType flash.events.Event.SCROLL
	 */
	[Event(name="scroll", type="flash.events.Event")]
	
	/**
	 * @eventType flash.events.Event.TEXT_INTERACTION_MODE_CHANGE
	 */
	[Event(name="textInteractionModeChange", type="flash.events.Event")]
	
	/**
	 * <code>Label</code> 类定义一行或多行不可编辑的文本.
	 * @author wizardc
	 */
	public class Label extends AbstractText
	{
		/**
		 * 记录是否根据文本自动调整尺寸.
		 */
		protected var _autoSize:Boolean = true;
		
		/**
		 * 记录是否使用 HTML 格式呈现文本.
		 */
		protected var _useHTML:Boolean = false;
		
		/**
		 * 创建一个 <code>Label</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function Label(skinClass:Class = null)
		{
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			//抛出内部事件
			_textField.addEventListener(TextEvent.LINK, this.dispatchEventHandler);
			_textField.addEventListener(Event.SCROLL, this.dispatchEventHandler);
			_textField.addEventListener(Event.TEXT_INTERACTION_MODE_CHANGE, this.dispatchEventHandler);
			//设置默认属性
			_textField.autoSize = TextFieldAutoSize.LEFT;
			_textField.condenseWhite = false;
			_textField.multiline = false;
			_textField.selectable = false;
			_textField.wordWrap = false;
			//设置文本样式
			this.setTextFormat();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractLabelSkin;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createDefaultSkin():ISkin
		{
			return SkinManager.getInstance().defaultTheme.getDefaultSkin(this);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set width(value:Number):void
		{
			if(_autoSize)
			{
				_textField.width = value;
			}
			else
			{
				super.width = value;
			}
		}
		override public function get width():Number
		{
			if(_autoSize)
			{
				return _textField.width;
			}
			return super.width;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set height(value:Number):void
		{
			if(_autoSize)
			{
				_textField.height = value;
			}
			else
			{
				super.height = value;
			}
		}
		override public function get height():Number
		{
			if(_autoSize)
			{
				return _textField.height;
			}
			return super.height;
		}
		
		/**
		 * 设置或获取是否根据文本自动调整尺寸.
		 */
		public function set autoSize(value:Boolean):void
		{
			if(_autoSize != value)
			{
				_autoSize = value;
				//保留文本自动调整的尺寸
				if(!_autoSize)
				{
					_width = _textField.width;
					_height = _textField.height;
				}
				//还原为不自动调整尺寸时文本框的尺寸会还原
				_textField.autoSize = _autoSize ? TextFieldAutoSize.LEFT : TextFieldAutoSize.NONE;
				//设置文本尺寸为自动调整的尺寸
				if(!_autoSize)
				{
					_textField.width = _width;
					_textField.height = _height;
				}
			}
		}
		public function get autoSize():Boolean
		{
			return _autoSize;
		}
		
		/**
		 * 设置或获取是否删除具有 HTML 文本的文本字段中的额外空白.
		 */
		public function set condenseWhite(value:Boolean):void
		{
			_textField.condenseWhite = value;
		}
		public function get condenseWhite():Boolean
		{
			return _textField.condenseWhite;
		}
		
		/**
		 * 设置或获取是否为多行文本.
		 */
		public function set multiline(value:Boolean):void
		{
			_textField.multiline = value;
		}
		public function get multiline():Boolean
		{
			return _textField.multiline;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set text(value:String):void
		{
			if(this.text != value)
			{
				if(_useHTML)
				{
					_textField.htmlText = value;
				}
				else
				{
					_textField.text = value;
					this.setTextFormat();
				}
			}
		}
		override public function get text():String
		{
			if(_useHTML)
			{
				return _textField.htmlText;
			}
			return _textField.text;
		}
		
		/**
		 * 设置或获取是否使用 HTML 格式呈现文本.
		 */
		public function set useHTML(value:Boolean):void
		{
			if(this.useHTML != value)
			{
				var text:String = this.text;
				_useHTML = value;
				this.text = text;
			}
		}
		public function get useHTML():Boolean
		{
			return _useHTML;
		}
		
		/**
		 * 设置或获取文本字段是否自动换行.
		 */
		public function set wordWrap(value:Boolean):void
		{
			_textField.wordWrap = value;
		}
		public function get wordWrap():Boolean
		{
			return _textField.wordWrap;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setSize(width:Number, height:Number):void
		{
			if(_autoSize)
			{
				_textField.width = width;
				_textField.height = height;
			}
			else
			{
				super.setSize(width, height);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function layout():void
		{
			if(!_autoSize)
			{
				super.layout();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setTextFormat():void
		{
			if(!_useHTML)
			{
				super.setTextFormat();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function appendText(newText:String):void
		{
			if(_useHTML)
			{
				_textField.htmlText += newText;
			}
			else
			{
				_textField.appendText(newText);
				this.setTextFormat();
			}
		}
	}
}
