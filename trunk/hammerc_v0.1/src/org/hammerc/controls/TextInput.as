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
	
	import org.hammerc.controls.supportClasses.Margin;
	import org.hammerc.controls.textClasses.AbstractText;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.controls.AbstractTextInputSkin;
	
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
	 * <code>TextInput</code> 类定义可选择编辑的单行文本输入框.
	 * @author wizardc
	 */
	public class TextInput extends AbstractText
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
		 * 记录背景显示对象.
		 */
		protected var _background:Sprite;
		
		/**
		 * 创建一个 <code>TextInput</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function TextInput(skinClass:Class = null)
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
			//抛出内部事件
			_textField.addEventListener(Event.CHANGE, this.dispatchEventHandler);
			_textField.addEventListener(Event.SCROLL, this.dispatchEventHandler);
			_textField.addEventListener(TextEvent.TEXT_INPUT, this.dispatchEventHandler);
			_textField.addEventListener(Event.TEXT_INTERACTION_MODE_CHANGE, this.dispatchEventHandler);
			//设置默认属性
			_textField.alwaysShowSelection = true;
			_textField.autoSize = TextFieldAutoSize.NONE;
			_textField.displayAsPassword = false;
			_textField.maxChars = 0;
			_textField.multiline = false;
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
			return AbstractTextInputSkin;
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
		 * 获取背景显示对象.
		 */
		hammerc_internal function get background():Sprite
		{
			return _background;
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
		 * @inheritDoc
		 */
		override protected function layout():void
		{
			var textWidth:Number = _width - _textMargin.left - _textMargin.right;
			var textHeight:Number = _height - _textMargin.top - _textMargin.bottom;
			_textField.visible = (textWidth > 0 && textHeight > 0);
			_textField.x = _textMargin.left;
			_textField.y = _textMargin.top;
			_textField.width = textWidth;
			_textField.height = textHeight;
		}
	}
}
