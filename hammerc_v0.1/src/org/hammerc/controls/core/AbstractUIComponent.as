/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.hammerc.containers.core.IUIContainer;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.events.ResizedEvent;
	import org.hammerc.events.UIEvent;
	import org.hammerc.manager.InvalidateManager;
	import org.hammerc.manager.ToolTipManager;
	import org.hammerc.manager.invalidateClasses.IInvalidating;
	import org.hammerc.manager.toolTipClasses.ToolTipPosition;
	import org.hammerc.skin.AbstractSkin;
	import org.hammerc.skin.ISkin;
	
	use namespace hammerc_internal;
	
	/**
	 * @eventType org.hammerc.events.ResizedEvent.RESIZED
	 */
	[Event(name="resized", type="org.hammerc.events.ResizedEvent")]
	
	/**
	 * @eventType org.hammerc.events.UIEvent.HIDE
	 */
	[Event(name="hide", type="org.hammerc.events.UIEvent")]
	
	/**
	 * @eventType org.hammerc.events.UIEvent.SHOW
	 */
	[Event(name="show", type="org.hammerc.events.UIEvent")]
	
	/**
	 * @eventType org.hammerc.events.UIEvent.SKIN_CHANGED
	 */
	[Event(name="skinChanged", type="org.hammerc.events.UIEvent")]
	
	/**
	 * @eventType org.hammerc.events.ToolTipEvent.TOOL_TIP_SHOW
	 */
	[Event(name="toolTipShow", type="org.hammerc.events.ToolTipEvent")]
	
	/**
	 * @eventType org.hammerc.events.ToolTipEvent.TOOL_TIP_HIDE
	 */
	[Event(name="toolTipHide", type="org.hammerc.events.ToolTipEvent")]
	
	/**
	 * @eventType org.hammerc.eventsDragEvent.DRAG_START
	 */
	[Event(name="dragStart", type="org.hammerc.events.DragEvent")]
	
	/**
	 * @eventType org.hammerc.eventsDragEvent.DRAG_COMPLETE
	 */
	[Event(name="dragComplete", type="org.hammerc.events.DragEvent")]
	
	/**
	 * @eventType org.hammerc.eventsDragEvent.DRAG_ENTER
	 */
	[Event(name="dragEnter", type="org.hammerc.events.DragEvent")]
	
	/**
	 * @eventType org.hammerc.eventsDragEvent.DRAG_EXIT
	 */
	[Event(name="dragExit", type="org.hammerc.events.DragEvent")]
	
	/**
	 * @eventType org.hammerc.eventsDragEvent.DRAG_DROP
	 */
	[Event(name="dragDrop", type="org.hammerc.events.DragEvent")]
	
	/**
	 * <code>AbstractUIComponent</code> 类为所有组件的基类, 定义了组件的基本属性及方法.
	 * @author wizardc
	 */
	public class AbstractUIComponent extends Sprite implements IUIComponent, IInvalidating, IToolTip
	{
		/**
		 * 记录组件初始化是否完成.
		 */
		protected var _initialized:Boolean = false;
		
		/**
		 * 记录组件的宽度.
		 */
		protected var _width:Number = 0;
		
		/**
		 * 记录组件的高度.
		 */
		protected var _height:Number = 0;
		
		/**
		 * 记录组件是否可以接受用户交互.
		 */
		protected var _enabled:Boolean = true;
		
		/**
		 * 记录组件的皮肤绘制类.
		 */
		protected var _skinClass:Class;
		
		/**
		 * 记录组件的皮肤绘制实例.
		 */
		protected var _skin:ISkin;
		
		/**
		 * 记录当鼠标在组件上按下时, 是否能够自动获得焦点.
		 */
		protected var _focusEnabled:Boolean = false;
		
		/**
		 * 记录组件在显示列表中嵌套的层深度.
		 */
		protected var _nestLevel:int;
		
		/**
		 * 记录组件的布局是否失效.
		 */
		protected var _invalidateLayoutFlag:Boolean = false;
		
		/**
		 * 记录组件的显示是否失效.
		 */
		protected var _invalidateShowFlag:Boolean = false;
		
		/**
		 * 记录组件的工具提示的内容.
		 */
		protected var _toolTip:Object;
		
		/**
		 * 记录组件的工具提示的渲染类, 为空使用默认的渲染类.
		 */
		protected var _toolTipRenderer:Class;
		
		/**
		 * 记录组件工具提示的弹出位置.
		 */
		protected var _toolTipPosition:String = ToolTipPosition.FOLLOW_MOUSE;
		
		/**
		 * 记录组件工具提示的弹出位置的偏移量.
		 */
		protected var _toolTipOffset:Point;
		
		/**
		 * 记录组件是否可见.
		 */
		protected var _visible:Boolean = true;
		
		private var _mouseEnabled:Boolean = true;
		private var _mouseChildren:Boolean = true;
		private var _tabEnabled:Boolean = false;
		private var _tabChildren:Boolean = true;
		private var _useHandCursor:Boolean = true;
		
		/**
		 * <code>AbstractUIComponent</code> 类为抽象类, 不能被实例化.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function AbstractUIComponent(skinClass:Class = null)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractUIComponent);
			this.focusRect = false;
			//初始化组件属性
			this.init();
			//创建组件使用到的皮肤对象
			this.skinClass = skinClass;
			//创建子显示对象, 如果是子组件则需要从皮肤类取默认子组件的皮肤类对象
			this.createChildren();
			//装载皮肤应等到内部所有子对象都创建后再进行, 否则皮肤对象会取不到组件内部对象
			this.skin.load();
			_initialized = true;
		}
		
		/**
		 * 组件初始化时调用该方法.
		 * <p>不要在该方法内访问该对象的子显示对象, 子显示此时对象尚未创建.</p>
		 */
		protected function init():void
		{
		}
		
		/**
		 * 添加子组件对象时调用该方法.
		 * <p>最主要的功能为添加组件对象时获取其皮肤类.</p>
		 */
		protected function createChildren():void
		{
		}
		
		/**
		 * 获取组件初始化是否完成.
		 */
		hammerc_internal function get initialized():Boolean
		{
			return _initialized;
		}
		
		/**
		 * 设置或获取组件的宽度.
		 */
		override public function set width(value:Number):void
		{
			if(_width != value)
			{
				this.setSize(value, _height);
			}
		}
		override public function get width():Number
		{
			return _width;
		}
		
		/**
		 * 设置或获取组件的高度.
		 */
		override public function set height(value:Number):void
		{
			if(_height != value)
			{
				this.setSize(_width, value);
			}
		}
		override public function get height():Number
		{
			return _height;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set enabled(value:Boolean):void
		{
			if(_enabled != value)
			{
				_enabled = value;
				super.mouseEnabled = _enabled ? _mouseEnabled : false;
				super.mouseChildren = _enabled ? _mouseChildren : false;
				super.tabEnabled = _enabled ? _tabEnabled : false;
				super.tabChildren = _enabled ? _tabChildren : false;
				super.useHandCursor = _enabled ? _useHandCursor : false;
				this.onEnabledChanged(_enabled);
				(_skin as AbstractSkin).onEnabledChanged(_enabled);
				this.invalidateShow();
			}
		}
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		/**
		 * 当组件是否可以接受用户交互的值改变后会调用该方法.
		 * @param enabled 新设置的组件是否可以接受用户交互的值.
		 */
		protected function onEnabledChanged(enabled:Boolean):void
		{
		}
		
		/**
		 * @private
		 */
		override public function set mouseEnabled(value:Boolean):void
		{
			if(_enabled)
			{
				super.mouseEnabled = value;
			}
			_mouseEnabled = value;
		}
		override public function get mouseEnabled():Boolean
		{
			return _mouseEnabled;
		}
		
		/**
		 * @private
		 */
		override public function set mouseChildren(value:Boolean):void
		{
			if(_enabled)
			{
				super.mouseChildren = value;
			}
			_mouseChildren = value;
		}
		override public function get mouseChildren():Boolean
		{
			return _mouseChildren;
		}
		
		/**
		 * @private
		 */
		override public function set tabEnabled(value:Boolean):void
		{
			if(_enabled)
			{
				super.tabEnabled = value;
			}
			_tabEnabled = value;
		}
		override public function get tabEnabled():Boolean
		{
			return _tabEnabled;
		}
		
		/**
		 * @private
		 */
		override public function set tabChildren(value:Boolean):void
		{
			if(_enabled)
			{
				super.tabChildren = value;
			}
			_tabChildren = value;
		}
		override public function get tabChildren():Boolean
		{
			return _tabChildren;
		}
		
		/**
		 * @private
		 */
		override public function set useHandCursor(value:Boolean):void
		{
			if(_enabled)
			{
				super.useHandCursor = value;
			}
			_useHandCursor = value;
		}
		override public function get useHandCursor():Boolean
		{
			return _useHandCursor;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set skinClass(value:Class):void
		{
			if(_initialized && _skinClass == value)
			{
				return;
			}
			if(_skin != null)
			{
				_skin.unload();
			}
			_skinClass = value;
			if(_skinClass == null)
			{
				_skin = this.createDefaultSkin();
			}
			else
			{
				_skin = new _skinClass(this) as ISkin;
			}
			if(!_skin is this.validSkinClass())
			{
				throw new Error("设置的皮肤类无效！");
			}
			else if(_initialized)
			{
				_skin.load();
				this.dispatchEvent(new UIEvent(UIEvent.SKIN_CHANGED));
			}
		}
		public function get skinClass():Class
		{
			return _skinClass;
		}
		
		/**
		 * 获取当前组件皮肤绘制对象的实例.
		 */
		public function get skin():ISkin
		{
			return _skin;
		}
		
		/**
		 * 获取该组件可接收的皮肤类, 可以设置 skinClass 为本方法返回的类或该类的子类.
		 * @return 该组件可接收的皮肤类.
		 */
		protected function validSkinClass():Class
		{
			return AbstractSkin;
		}
		
		/**
		 * 创建默认的皮肤类实例.
		 * @return 默认的皮肤类实例.
		 */
		protected function createDefaultSkin():ISkin
		{
			AbstractEnforcer.enforceMethod();
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set focusEnabled(value:Boolean):void
		{
			_focusEnabled = value;
		}
		public function get focusEnabled():Boolean
		{
			return _focusEnabled;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get nestLevel():int
		{
			return _nestLevel;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set toolTip(value:Object):void
		{
			if(_toolTip != value)
			{
				var oldValue:Object = _toolTip;
				_toolTip = value;
				ToolTipManager.getInstance().hammerc_internal::registerToolTip(this, oldValue, _toolTip);
			}
		}
		public function get toolTip():Object
		{
			return _toolTip;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set toolTipRenderer(value:Class):void
		{
			_toolTipRenderer = value;
		}
		public function get toolTipRenderer():Class
		{
			return _toolTipRenderer;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set toolTipPosition(value:String):void
		{
			_toolTipPosition = value;
		}
		public function get toolTipPosition():String
		{
			return _toolTipPosition;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set toolTipOffset(value:Point):void
		{
			_toolTipOffset = value;
		}
		public function get toolTipOffset():Point
		{
			return _toolTipOffset;
		}
		
		/**
		 * 设置或获取组件是否可见.
		 */
		override public function set visible(value:Boolean):void
		{
			if(_visible != value)
			{
				super.visible = _visible = value;
				if(_visible)
				{
					this.dispatchEvent(new UIEvent(UIEvent.SHOW));
				}
				else
				{
					this.dispatchEvent(new UIEvent(UIEvent.HIDE));
				}
			}
		}
		override public function get visible():Boolean
		{
			return _visible;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setFocus():void
		{
			if(this.stage != null)
			{
				this.stage.focus = this;
			}
		}
		
		/**
		 * 设置组件的位置.
		 * @param x 组件的 x 轴坐标.
		 * @param y 组件的 y 轴坐标.
		 */
		public function setLocation(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		
		/**
		 * 设置组件的尺寸.
		 * @param width 组件的宽度.
		 * @param height 组件的高度.
		 */
		public function setSize(width:Number, height:Number):void
		{
			if(_width != width || _height != height)
			{
				var oldWidth:Number = _width, oldHeight:Number = _height;
				_width = width;
				_height = height;
				this.onSizeChanged(_width, _height);
				(_skin as AbstractSkin).onSizeChanged(_width, _height);
				this.invalidateLayout();
				this.invalidateShow();
				this.dispatchEvent(new ResizedEvent(ResizedEvent.RESIZED, oldWidth, oldHeight));
			}
		}
		
		/**
		 * 当组件的尺寸改变后会调用该方法.
		 * @param width 新设置的组件宽度.
		 * @param height 新设置的组件高度.
		 */
		protected function onSizeChanged(width:Number, height:Number):void
		{
		}
		
		/**
		 * 直接操作皮肤类设定一个风格.
		 * @param name 要设定的风格名称.
		 * @param value 要设定的风格的值.
		 */
		public function setStyle(name:String, value:*):void
		{
			(_skin as AbstractSkin).setStyle(name, value);
		}
		
		/**
		 * 获取皮肤类中指定的一个风格.
		 * @param name 要获取的风格名称.
		 * @return 指定的风格.
		 */
		public function getStyle(name:String):*
		{
			return (_skin as AbstractSkin).getStyle(name);
		}
		
		/**
		 * 播放内部元件的事件.
		 * @param event 需要进行播放的事件对象.
		 */
		protected function dispatchEventHandler(event:Event):void
		{
			this.dispatchEvent(event);
		}
		
		/**
		 * @inheritDoc
		 */
		public function get parentContainer():IUIContainer
		{
			var container:DisplayObject;
			if(this.parent != null)
			{
				container = this.parent.parent;
			}
			return container as IUIContainer;
		}
		
		/**
		 * @inheritDoc
		 */
		public function calculateNestLevel():void
		{
			_nestLevel = 0;
			var parent:DisplayObject = this.parent;
			while(parent != this.stage)
			{
				parent = parent.parent;
				_nestLevel++;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function invalidateLayout():void
		{
			if(!_invalidateLayoutFlag)
			{
				_invalidateLayoutFlag = true;
				InvalidateManager.getInstance().invalidateLayout(this);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function validateLayout():void
		{
			if(_invalidateLayoutFlag)
			{
				_invalidateLayoutFlag = false;
				this.layout();
			}
		}
		
		/**
		 * 延迟渲染第一阶段, 布局内部对象或延迟的操作逻辑都可以写在该方法中.
		 */
		protected function layout():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function validateLayoutNow():void
		{
			this.validateLayout();
		}
		
		/**
		 * @inheritDoc
		 */
		public function invalidateShow():void
		{
			if(!_invalidateShowFlag)
			{
				_invalidateShowFlag = true;
				InvalidateManager.getInstance().invalidateShow(this);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function validateShow():void
		{
			if(_invalidateShowFlag)
			{
				_invalidateShowFlag = false;
				_skin.drawSkin();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function validateShowNow():void
		{
			this.validateShow();
		}
	}
}
