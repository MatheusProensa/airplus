package login
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.Timer;
   import onBoardingHcUi.Button;
   import onBoardingHcUi.ColouredButton;
   import onBoardingHcUi.LoaderUI;
   
   public class EnvironmentView extends Sprite implements IComponentInterfaceQueue
   {
      private static const ITEMS_PER_ROW:int = 9;
      
      private static const THUMB_SIZE:int = 160;
      
      private static const THUMB_SCALE:Number = 0.5;
      
      private static const SPACING:int = 10;
      
      private static const flag_icon_de_png:Class = flag_icons_de_1_png;
      
      private static const flag_icon_dev_png:Class = flag_icons_dev_1_png;
      
      private static const flag_icon_en_png:Class = flag_icons_en_1_png;
      
      private static const flag_icon_es_png:Class = flag_icons_es_1_png;
      
      private static const flag_icon_fi_png:Class = flag_icons_fi_1_png;
      
      private static const flag_icon_fr_png:Class = flag_icons_fr_1_png;
      
      private static const flag_icon_it_png:Class = flag_icons_it_1_png;
      
      private static const flag_icon_nl_png:Class = flag_icons_nl_1_png;
      
      private static const flag_icon_pt_png:Class = flag_icons_pt_1_png;
      
      private static const flag_icon_tr_png:Class = flag_icons_tr_1_png;
      
      private static const flag_icon_selected_png:Class = flags_icon_selected_1_png;
      
      private var _environmentImages:Vector.<Bitmap>;
      
      private var _context:LoginFlow;
      
      private var UnknownVarFromEnvironmentView_TextField_1:TextField;
      
      private var UnknownVarFromEnvironmentView_Bitmap_1:Bitmap;
      
      private var _environmentName:TextField;
      
      private var UnknownVarFromEnvironmentView_Int_1:int = 0;
      
      private var UnknownVarFromEnvironmentView_Button_1:Button;
      
      private var UnknownVarFromEnvironmentView_Button_2:Button;
      
      private var _environmentImageContainers:Array = [];
      
      private var UnknownVarFromEnvironmentView_Bitmap_2:Bitmap;
      
      private var _spaceBetweenImages:int = 10;
      
      private var _environmentTypes:Array;
      
      private var UnknownVarFromEnvironmentView_Boolean_1:Boolean;
      
      private var UnknownVarFromEnvironmentView_Sprite_1:Sprite;
      
      public function EnvironmentView(param1:LoginFlow)
      {
         super();
         _context = param1;
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var _loc2_:Timer = new Timer(20,1);
         _loc2_.addEventListener("timerComplete",onAlignElements);
         _loc2_.start();
      }
      
      private function onAlignElements(param1:TimerEvent = null) : void
      {
         LoaderUI.alignAnchors(this,0,"c",UnknownVarFromEnvironmentView_Bitmap_1);
         if(UnknownVarFromEnvironmentView_Button_1)
         {
            LoaderUI.alignAnchors(UnknownVarFromEnvironmentView_Bitmap_1,0,"r",UnknownVarFromEnvironmentView_Button_1);
            LoaderUI.lineUpHorizontallyRevers(UnknownVarFromEnvironmentView_Button_1,20,UnknownVarFromEnvironmentView_Button_2);
         }
         else
         {
            LoaderUI.alignAnchors(UnknownVarFromEnvironmentView_Bitmap_1,0,"r",UnknownVarFromEnvironmentView_Button_2);
         }
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromEnvironmentView_Button_1)
         {
            UnknownVarFromEnvironmentView_Button_1.dispose();
         }
         UnknownVarFromEnvironmentView_Button_2.dispose();
         for each(var _loc1_ in _environmentImages)
         {
         }
         _environmentImages = null;
         _context = null;
      }
      
      public function get disposed() : Boolean
      {
         return _context == null;
      }
      
      private function initEnvironmentImages() : void
      {
         _environmentTypes = _context.getProperty("live.environment.list").split("/");
         _environmentImages.push(Bitmap(new flag_icon_en_png()));
         _environmentImages.push(Bitmap(new flag_icon_pt_png()));
         _environmentImages.push(Bitmap(new flag_icon_de_png()));
         _environmentImages.push(Bitmap(new flag_icon_es_png()));
         _environmentImages.push(Bitmap(new flag_icon_fi_png()));
         _environmentImages.push(Bitmap(new flag_icon_fr_png()));
         _environmentImages.push(Bitmap(new flag_icon_it_png()));
         _environmentImages.push(Bitmap(new flag_icon_nl_png()));
         _environmentImages.push(Bitmap(new flag_icon_tr_png()));
         _environmentImages.push(Bitmap(new flag_icon_dev_png()));
      }
      
      public function init() : void
      {
         if(UnknownVarFromEnvironmentView_Boolean_1)
         {
            return;
         }
         UnknownVarFromEnvironmentView_Boolean_1 = true;
         _environmentImages = new Vector.<Bitmap>();
         if(_environmentTypes == null)
         {
            initEnvironmentImages();
         }
         updateEnvironment();
         initView();
      }
      
      public function updateEnvironment() : void
      {
         var _loc1_:String = _context.getProperty("environment.id");
         var _loc2_:int = int(_environmentTypes.indexOf(_loc1_));
         if(_loc2_ == -1)
         {
            Logger.log("Missing environment, require hotel selection! " + _loc1_);
            UnknownVarFromEnvironmentView_Int_1 = 0;
         }
         else
         {
            UnknownVarFromEnvironmentView_Int_1 = _loc2_;
         }
         chooseEnvironment();
      }
      
      public function initView() : void
      {
         var _loc7_:int = 0;
         var _loc8_:Sprite = null;
         var _loc10_:Bitmap = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         addTitleField();
         UnknownVarFromEnvironmentView_Bitmap_1 = LoaderUI.createBalloon(640,100,0,false,995918,"none");
         UnknownVarFromEnvironmentView_Bitmap_1.visible = false;
         addChild(UnknownVarFromEnvironmentView_Bitmap_1);
         UnknownVarFromEnvironmentView_Sprite_1 = new Sprite();
         addChild(UnknownVarFromEnvironmentView_Sprite_1);
         UnknownVarFromEnvironmentView_Bitmap_2 = Bitmap(new flag_icon_selected_png());
         UnknownVarFromEnvironmentView_Sprite_1.addChild(UnknownVarFromEnvironmentView_Bitmap_2);
         UnknownVarFromEnvironmentView_Sprite_1.scaleX = UnknownVarFromEnvironmentView_Sprite_1.scaleY = 0.5;
         var _loc1_:int = 100;
         _loc7_ = 0;
         while(_loc7_ < _environmentImages.length)
         {
            _loc8_ = new Sprite();
            _loc10_ = _environmentImages[_loc7_] as Bitmap;
            if(_loc10_ != null)
            {
               _loc8_.addChild(_loc10_);
            }
            addChild(_loc8_);
            _environmentImageContainers.push(_loc8_);
            _loc8_.name = String(_loc7_);
            _loc8_.addEventListener("click",onEnvironmentClick);
            _loc8_.scaleX = _loc8_.scaleY = 0.5;
            _loc3_ = 80;
            _loc2_ = 5;
            _loc6_ = _loc7_ % 9;
            _loc9_ = _loc7_ / 9;
            _loc4_ = _loc6_ * _loc3_ + _loc6_ * _loc2_;
            _loc5_ = _loc9_ * _loc3_ + _loc9_ * _loc2_;
            _loc8_.x = _loc4_;
            _loc8_.y = _loc1_ + _loc5_;
            _loc7_++;
         }
         _environmentName = LoaderUI.createTextField("Title",20,16777215,false,true,false,false);
         _environmentName.width = 260;
         _environmentName.y = 300;
         addChild(_environmentName);
         UnknownVarFromEnvironmentView_Button_2 = new ColouredButton("gfreen","${connection.login.useTicket}",new Rectangle(0,300,0,40),true,onButtonSelectToken);
         addChild(UnknownVarFromEnvironmentView_Button_2);
         chooseEnvironment();
      }
      
      private function addTitleField() : void
      {
         if(!UnknownVarFromEnvironmentView_TextField_1)
         {
            UnknownVarFromEnvironmentView_TextField_1 = LoaderUI.createTextField("${connection.login.environment.choose}",40,16777215,false,true,false,false,"left");
            UnknownVarFromEnvironmentView_TextField_1.x = 0;
            UnknownVarFromEnvironmentView_TextField_1.y = 0;
            UnknownVarFromEnvironmentView_TextField_1.width = 500;
            UnknownVarFromEnvironmentView_TextField_1.multiline = false;
            UnknownVarFromEnvironmentView_TextField_1.thickness = 50;
            addChild(UnknownVarFromEnvironmentView_TextField_1);
         }
      }
      
      private function onEnvironmentClick(param1:Event) : void
      {
         UnknownVarFromEnvironmentView_Int_1 = int(param1.currentTarget.name);
         chooseEnvironment();
         _context.updateEnvironment(_environmentTypes[UnknownVarFromEnvironmentView_Int_1],true);
         onAlignElements();
      }
      
      private function chooseEnvironment() : void
      {
         var _loc1_:Sprite = _environmentImageContainers[UnknownVarFromEnvironmentView_Int_1];
         if(_loc1_ == null)
         {
            return;
         }
         UnknownVarFromEnvironmentView_Sprite_1.x = _loc1_.x - (UnknownVarFromEnvironmentView_Sprite_1.width - _loc1_.width) / 2 - 1;
         UnknownVarFromEnvironmentView_Sprite_1.y = _loc1_.y - (UnknownVarFromEnvironmentView_Sprite_1.height - _loc1_.height) / 2 - 1;
         UnknownVarFromEnvironmentView_Sprite_1.visible = true;
         if(UnknownVarFromEnvironmentView_Button_1)
         {
            UnknownVarFromEnvironmentView_Button_1.active = true;
         }
         updateDescription();
      }
      
      private function onButtonSelect(param1:DisplayObject) : void
      {
         _context.updateEnvironment(_environmentTypes[UnknownVarFromEnvironmentView_Int_1],false);
         _context.showScreen(2);
      }
      
      private function onButtonSelectToken(param1:DisplayObject) : void
      {
         _context.updateEnvironment(_environmentTypes[UnknownVarFromEnvironmentView_Int_1],false);
         _context.showScreen(4);
      }
      
      private function updateDescription() : void
      {
         var _loc1_:String = _environmentTypes[UnknownVarFromEnvironmentView_Int_1];
         _environmentName.text = _context.getProperty("connection.info.name." + _loc1_);
      }
      
      public function get environmentId() : String
      {
         return _environmentTypes[UnknownVarFromEnvironmentView_Int_1];
      }
      
      public function get environmentAvailable() : Boolean
      {
         var _loc1_:String = _context.getProperty("environment.id");
         return _environmentTypes.indexOf(_loc1_) > -1;
      }
   }
}

