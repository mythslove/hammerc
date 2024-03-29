/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.display
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import org.hammerc.extender.OpaqueInteractiveExtender;
	
	/**
	 * <code>OpaqueInteractiveMovieClip</code> 类提供支持位图不透明部分鼠标交互的影片剪辑扩展.
	 * <p>使用方法: 不应该在程序中直接创建, 在 Flash IDE 中连接一个需要改扩展功能的影片剪辑时请设置其基类为本类.</p>
	 * @author wizardc
	 */
	public class OpaqueInteractiveMovieClip extends MovieClip
	{
		/**
		 * 支持位图不透明部分鼠标交互的扩展对象.
		 */
		protected var _opaqueInteractiveExtender:OpaqueInteractiveExtender;
		
		/**
		 * 记录所有帧对应的位图数据对象.
		 */
		protected var _bitmapDataList:Vector.<BitmapData>;
		
		/**
		 * 记录当前鼠标指向的点是否可以当做透明处理.
		 */
		protected var _transparent:Boolean = false;
		
		/**
		 * 记录此对象是否接收鼠标消息.
		 */
		protected var _mouseEnabled:Boolean = true;
		
		/**
		 * 创建一个 <code>OpaqueInteractiveMovieClip</code> 对象.
		 */
		public function OpaqueInteractiveMovieClip()
		{
			_opaqueInteractiveExtender = new OpaqueInteractiveExtender(this, 127);
			_bitmapDataList = new Vector.<BitmapData>();
			randerOpaqueArea();
			this.addMouseEventListener();
		}
		
		/**
		 * 设置或获取此对象是否接收鼠标消息.
		 */
		override public function set mouseEnabled(value:Boolean):void
		{
			_mouseEnabled = value;
			if(_mouseEnabled)
			{
				this.addMouseEventListener();
				super.mouseEnabled = true;
			}
			else
			{
				this.removeMouseEventListener();
				this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				super.mouseEnabled = false;
			}
		}
		override public function get mouseEnabled():Boolean
		{
			return _mouseEnabled;
		}
		
		/**
		 * 设置或获取透明度的阀值, 像素点的透明度小于等于该值则该点不进行交互, 有效范围 [0~255].
		 */
		public function set threshold(value:int):void
		{
			_opaqueInteractiveExtender.threshold = value;
		}
		public function get threshold():int
		{
			return _opaqueInteractiveExtender.threshold;
		}
		
		private function randerOpaqueArea():void
		{
			for(var i:int = 0, len:int = this.totalFrames; i < len; i++)
			{
				this.gotoAndStop(i + 1);
				var bounds:Rectangle = this.getBounds(this);
				if(!bounds.isEmpty())
				{
					var bitmapData:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0x00000000);
					var matrix:Matrix = new Matrix();
					matrix.translate(-bounds.left, -bounds.top);
					bitmapData.draw(this, matrix);
					_bitmapDataList.push(bitmapData);
				}
				else
				{
					_bitmapDataList.push(null);
				}
			}
			this.gotoAndPlay(1);
		}
		
		/**
		 * 添加鼠标移动时的事件侦听.
		 */
		protected function addMouseEventListener():void
		{
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseEventHandler, false, int.MAX_VALUE, false);
			this.addEventListener(MouseEvent.ROLL_OVER, mouseEventHandler, false, int.MAX_VALUE, false);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseEventHandler, false, int.MAX_VALUE, false);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseEventHandler, false, int.MAX_VALUE, false);
			this.addEventListener(MouseEvent.MOUSE_MOVE, mouseEventHandler, false, int.MAX_VALUE, false);
		}
		
		private function mouseEventHandler(event:MouseEvent):void
		{
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, int.MAX_VALUE, false);
			enterFrameHandler();
			//如果当前指向点是透明的则截断事件流
			if(_transparent)
			{
				event.stopImmediatePropagation();
			}
		}
		
		/**
		 * 移除鼠标移动时的事件侦听.
		 */
		protected function removeMouseEventListener():void
		{
			this.removeEventListener(MouseEvent.MOUSE_OVER, mouseEventHandler);
			this.removeEventListener(MouseEvent.ROLL_OVER, mouseEventHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT, mouseEventHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT, mouseEventHandler);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, mouseEventHandler);
		}
		
		private function enterFrameHandler(event:Event = null):void
		{
			var bounds:Rectangle = this.getBounds(this);
			_opaqueInteractiveExtender.bitmapData = _bitmapDataList[this.currentFrame - 1];
			_transparent = _opaqueInteractiveExtender.checkPoint(this.mouseX - bounds.left, this.mouseY - bounds.top);
			if(_transparent)
			{
				super.mouseEnabled = false;
			}
			else
			{
				super.mouseEnabled = true;
				/*
				* 在碰到不透明的像素后才移除事件侦听, 此时所有事件由 Flash 自己管理;
				* 事件移除必须放在此处, 如果在接收到鼠标移入事件时就移除所有事件, 会
				* 导致鼠标移入透明区域时播放部分事件导致出错.
				*/
				this.removeMouseEventListener();
			}
			//如果鼠标离开了本对象就移除进入帧事件
			if(!bounds.contains(this.mouseX, this.mouseY))
			{
				this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				super.mouseEnabled = true;
				this.addMouseEventListener();
			}
		}
	}
}
