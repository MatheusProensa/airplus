package com.vimeo.api
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.Timer;
   
   public class VimeoPlayer extends Sprite
   {
      private var container:Sprite = new Sprite();
      
      private var UnknownVarFromVimeoPlayer_Object_1:Object = false;
      
      private var UnknownVarFromVimeoPlayer_Sprite_1:Sprite = new Sprite();
      
      private var player_width:int = 400;
      
      private var player_height:int = 300;
      
      private var UnknownVarFromVimeoPlayer_Int_1:int = 2;
      
      private var load_timer:Timer = new Timer(200);
      
      public function VimeoPlayer(param1:String, param2:int, param3:int, param4:int, param5:String = "10", param6:int = 2)
      {
         super();
         this.setDimensions(param3,param4);
         Security.allowDomain("vimeo.com");
         Security.allowDomain("api.vimeo.com");
         var _loc10_:String = "&js_api=1";
         this.UnknownVarFromVimeoPlayer_Int_1 = param6;
         if(param5 != "9")
         {
            switch(param6 - 2)
            {
               case 0:
                  _loc10_ = "&api=1";
            }
         }
         else
         {
            this.UnknownVarFromVimeoPlayer_Int_1 = 1;
         }
         var _loc7_:URLRequest = new URLRequest("http://api.vimeo.com/moogaloop_api.swf?oauth_key=" + param1 + "&clip_id=" + param2 + "&width=" + param3 + "&height=" + param4 + "&fullscreen=0&fp_version=" + param5 + _loc10_ + "&cache_buster=" + Math.random() * 1000);
         var _loc8_:LoaderContext = new LoaderContext(true);
         var _loc9_:Loader = new Loader();
         _loc9_.contentLoaderInfo.addEventListener("complete",onComplete,false,0,true);
         _loc9_.load(_loc7_,_loc8_);
         this.addEventListener("addedToStage",addedToStageHandler,false,0,true);
      }
      
      public function destroy() : void
      {
         if(UnknownVarFromVimeoPlayer_Object_1 == null)
         {
            return;
         }
         if(UnknownVarFromVimeoPlayer_Object_1["destroy"] != undefined)
         {
            UnknownVarFromVimeoPlayer_Object_1.destroy();
         }
         if(container.contains(DisplayObject(UnknownVarFromVimeoPlayer_Object_1)))
         {
            container.removeChild(DisplayObject(UnknownVarFromVimeoPlayer_Object_1));
         }
         if(this.contains(UnknownVarFromVimeoPlayer_Sprite_1))
         {
            this.removeChild(UnknownVarFromVimeoPlayer_Sprite_1);
         }
         if(this.contains(container))
         {
            this.removeChild(container);
         }
         stage.removeEventListener("mouseMove",mouseMove);
      }
      
      private function setDimensions(param1:int, param2:int) : void
      {
         player_width = param1;
         player_height = param2;
      }
      
      private function onComplete(param1:Event) : void
      {
         container.addChild(param1.currentTarget.loader.content);
         UnknownVarFromVimeoPlayer_Object_1 = param1.currentTarget.loader.content;
         this.addChild(UnknownVarFromVimeoPlayer_Sprite_1);
         container.mask = UnknownVarFromVimeoPlayer_Sprite_1;
         this.addChild(container);
         redrawMask();
         load_timer.addEventListener("timer",playerLoadedCheck);
         load_timer.start();
      }
      
      private function playerLoadedCheck(param1:TimerEvent) : void
      {
         if(UnknownVarFromVimeoPlayer_Object_1.player_loaded)
         {
            load_timer.stop();
            load_timer.removeEventListener("timer",playerLoadedCheck);
            UnknownVarFromVimeoPlayer_Object_1.disableMouseMove();
            if(stage)
            {
               stage.addEventListener("mouseMove",mouseMove,false,0,true);
            }
            dispatchEvent(new Event("complete"));
         }
      }
      
      private function mouseMove(param1:Event) : void
      {
         var _loc2_:Point = null;
         var _loc3_:MouseEvent = param1 as MouseEvent;
         if(_loc3_ == null)
         {
            return;
         }
         if(UnknownVarFromVimeoPlayer_Object_1 && UnknownVarFromVimeoPlayer_Object_1.player_loaded)
         {
            _loc2_ = this.parent.localToGlobal(new Point(this.x,this.y));
            if(_loc3_.stageX >= _loc2_.x && _loc3_.stageX <= _loc2_.x + this.player_width && _loc3_.stageY >= _loc2_.y && _loc3_.stageY <= _loc2_.y + this.player_height)
            {
               UnknownVarFromVimeoPlayer_Object_1.mouseMove(_loc3_);
            }
            else
            {
               UnknownVarFromVimeoPlayer_Object_1.mouseOut();
            }
         }
      }
      
      private function redrawMask() : void
      {
         with(UnknownVarFromVimeoPlayer_Sprite_1.graphics)
         {
            beginFill(0,1);
            drawRect(container.x,container.y,player_width,player_height);
            endFill();
         }
      }
      
      public function play() : void
      {
         UnknownVarFromVimeoPlayer_Object_1.play();
      }
      
      public function pause() : void
      {
         UnknownVarFromVimeoPlayer_Object_1.pause();
      }
      
      public function getDuration() : int
      {
         return UnknownVarFromVimeoPlayer_Object_1.duration;
      }
      
      public function seekTo(param1:int) : void
      {
         UnknownVarFromVimeoPlayer_Object_1.seek(param1);
      }
      
      public function changeColor(param1:String) : void
      {
         UnknownVarFromVimeoPlayer_Object_1.color = uint("0x" + param1);
      }
      
      public function loadVideo(param1:int) : void
      {
         UnknownVarFromVimeoPlayer_Object_1.loadVideo(param1);
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this.setDimensions(param1,param2);
         UnknownVarFromVimeoPlayer_Object_1.setSize(param1,param2);
         this.redrawMask();
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         stage.addEventListener("mouseMove",mouseMove);
         this.addEventListener("removedFromStage",removedFromStageHandler,false,0,true);
      }
      
      private function removedFromStageHandler(param1:Event) : void
      {
         stage.removeEventListener("mouseMove",mouseMove);
         this.removeEventListener("removedFromStage",removedFromStageHandler);
      }
   }
}

