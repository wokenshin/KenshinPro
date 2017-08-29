//
//  BLEVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/5.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

//参考文章 http://www.jianshu.com/p/8ca610777de2
//code from kenshinApp
#import "BLEVC.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BLEVC ()<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager              *centralManager;//中心
@property (nonatomic, strong) CBPeripheral                  *peripheral;//外设
@property (nonatomic, strong) NSMutableArray                *mArrService;//保存发现的Service
@property (nonatomic, strong) NSMutableArray                *mArrCharacteristic;//保存发现的characteristic


@end

@implementation BLEVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"暂时没实现";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化中央设备，并设置代理[这里不推荐使用懒加载，因为测试后发现懒加载后 立即调用扫描方法是不会执行扫描的，需要第二次调用扫描才执行]
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    //-->centralManagerDidUpdateState:
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //释放资源 不这样的话 控制器无法释放
    [_centralManager stopScan];//停止扫描
    _centralManager = nil;
    
}

#pragma mark - 扫描蓝牙设备
- (IBAction)clickScanBleDevice:(id)sender
{
    //这里我们参数都传的是nil, 意思就是扫描所有的外设.当然你也可以传一个UUID进去,
    //是以数组的形式传的.这里由于我们做的是模拟第一次连接, 也就没有指定的UUID了, 有兴趣的可以自己测一下传一个UUID进去.
    [_centralManager scanForPeripheralsWithServices:nil options:nil];
    
    //-->#pragma mark - 扫描到设备时候的代理
    
    //---> centralManager:didDiscoverPeripheral:advertisementData:RSSI:
    
    //开始扫描之后 会执行代理 centralManager:didDiscoverPeripheral:advertisementData:RSSI:
    /*
     注意：如果第一个参数传的是nil，central manager会返回所有发现的peripheral，忽略它们支持的service。在真实的app中，
     你很可能会指定一个CBUUID数组对象，每个元素代表一个正在广播的peripheral service的UUID。若如此做，
     central manager只会返回广播对应service的peripheral，使你能够只扫描你可能感兴趣的设备。
     
     当你调用scanForPeripheralsWithServices:options:方法发现了哪些设备可用之后，central manager每发现一个peripheral就会调用一次delegate对象的centralManager:didDiscoverPeripheral:advertisementData:RSSI:方法。任何被发现的peripheral以CBPeripheral对象的形式返回。
     如下所示，你可以实现这个delegate方法列出所有发现的peripheral
     */
}

#pragma mark 停止扫描
- (IBAction)clickStopScan:(id)sender
{
    [_centralManager stopScan];
    
}

#pragma mark 连接设备
- (IBAction)clickConnectDevice:(id)sender
{
    if (self.peripheral)
    {
        [_centralManager connectPeripheral:self.peripheral options:nil];
        //如果连接请求成功，central manager会调用delegate对象的centralManager:didConnectPeripheral:
        //-->#pragma mark - 连接设备成功后的代理
    }
    else
    {
        NSLog(@">>>未找到设备， 更换设备名查找新的设备");
    }
}

#pragma mark 断开连接
- (IBAction)clickDisconnect:(id)sender
{
    if (self.peripheral)
    {
        [_centralManager cancelPeripheralConnection:self.peripheral];
    }
    
}


#pragma mark 发现服务中的特征值
- (IBAction)clickFindServiceCharac:(id)sender
{
    //假设你已经发现一个感兴趣的设备，探索peripheral所能提供的东西，下一步就是发现所有service提供的characteristic。
    //这个步骤很简单，只需调用CBPeripheral类的discoverCharacteristics:forService:
    //- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
    
    if ([self.mArrService count])
    {
        CBService *service = [self.mArrService firstObject];
        
        if (service)
        {
            [self.peripheral discoverCharacteristics:nil forService:service];
            //-->#pragma mark 发现服务中的特征值后的回调
            
            /*
             注意：在真实app中，第一个参数你很可能不会传nil，因为这样会返回一个peripheral service的所有characteristic。
             由于一个peripheral service包含的characteristic比你感兴趣的多的多，发现所有会浪费电量和时间。更可能的是，
             你会指定一个已知感兴趣的characteristic的UUID。
             */
            
            //----> - (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
        }

    }
    
}


#pragma mark - 获取Characteristic中的值[特征值是不变的]
- (IBAction)clickGetCharac:(id)sender
{
    /*
     获取characteristic的值
     
     一个characteristic只包含一个值，作为一个service的更多信息的展现。
     例如，一个体温计service的温度度量characteristic可能包含一个表示摄氏温度的值。
     你可以通过直接读取获取一个characteristic的值，也可以订阅它。
     
     读取characteristic的值
     当你从service中发现一个你感兴趣的characteristic之后，你可以通过调用CBPeripheral类的readValueForCharacteristic:方法读取这个characteristic值
     
     当你尝试读取一个characteristic值的时候，peripheral调用delegate对象的peripheral:didUpdateValueForCharacteristic:error:方法获取这个值。
     如果这个值获取成功，你可以通过characteristic的value属性访问到它
     */
    //    NSLog(@"Reading value for characteristic %@",     interestingCharacteristic);
    
    if ([self.mArrCharacteristic count])
    {
        CBCharacteristic *cha = [self.mArrCharacteristic firstObject];
        if (cha)
        {
            
            [self.peripheral readValueForCharacteristic:cha];
            //--->#pragma mark 读取Characteristic的值时的回调
        }
    }
    else
    {
        NSLog(@"Error: 没有获取到外围设备Service下的Characteristic");
    }

}


#pragma mark - 订阅特征值[特征值是可变的 就采用订阅的方式去获取]
- (IBAction)clickDingYueCharac:(id)sender
{
    /*
     虽然使用readValueForCharacteristic:读取characteristic值在某些场景很有效，它不是读取可变值的最有效率的方法。对于大多数可变characteristic值来说----例如你在任意时刻的心率----你应该通过订阅来读取它们。当你订阅了characteristic值，这个值变化时你会从peripheral收到通知。
     
     你可以通过调用CBPeripheral类的setNotifyValue:forCharacteristic:方法，并指定第一个参数为YES，来订阅你感兴趣的characteristic值，如下：
     */
    if ([self.mArrCharacteristic count])
    {
        //注意：不是所有characteristic值都被配置为支持订阅。你可以通过访问Characteristic Properties枚举中的相应常量来判定某个characteristic是否支持订阅
        CBCharacteristic *cha = [self.mArrCharacteristic firstObject];
        if (cha)
        {
            if (cha.properties == CBCharacteristicPropertyNotify)
            {
                NSLog(@"CBCharacteristicPropertyNotify");
            }
            
            [self.peripheral setNotifyValue:YES forCharacteristic:cha];
            //--->#pragma mark 订阅特征值之后 特征值发生变化时的回调
        }
        
    }
    else
    {
        NSLog(@"Error : 订阅特征值失败, 当前没有特征值 数据为空");
    }

}


#pragma mark - 写入特征值
- (IBAction)clickWriteCharac:(id)sender
{
    /*
     在某些场景中，有写入characteristic值的需求。例如你的app要和BLE数字恒温计交互，你可能想要给恒温计提供房间温度预设值。如果某个characteristic值是可写的，你可以通过调用CBPeripheral类的writeValue:forCharacteristic:type:
     方法写入一些数据（以NSData实例的形式），如下：
     */
    if ([self.mArrCharacteristic count])
    {
        CBCharacteristic *cha = [self.mArrCharacteristic firstObject];
        NSLog(@"Writing value for characteristic %@", cha);
        [self.peripheral writeValue:[NSData new] forCharacteristic:cha
                               type:CBCharacteristicWriteWithResponse];
        //--->#pragma mark - 写入特征值后的回调 [如果设备会相应的话]
    }
    else
    {
        NSLog(@"Error:写入特征值失败：characteristic == nil");
    }
    
}

#pragma mark - CBCentralManagerDelegate
//当CBCentralManager被创建的时候就会被调用 蓝牙状态发生改变的时候也会被调用
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state)
    {
        case CBManagerStateUnknown:
        {
            NSLog(@"BLE State: CBManagerStateUnknown");
            break;
        }
        case CBManagerStateResetting:
        {
            NSLog(@"BLE State: CBManagerStateResetting");
            break;
        }
        case CBManagerStateUnsupported:
        {
            NSLog(@"BLE State: CBManagerStateUnsupported");
            break;
        }
        case CBManagerStateUnauthorized:
        {
            NSLog(@"BLE State: CBManagerStateUnauthorized");
            break;
        }
        case CBManagerStatePoweredOff:
        {
            NSLog(@"BLE State: CBManagerStatePoweredOff");
            break;
        }
        case CBManagerStatePoweredOn:
        {
            NSLog(@"BLE State: CBManagerStatePoweredOn");
            break;
        }
            
        default:
            break;
    }

    
}

#pragma mark - 扫描到设备时候的代理
//CentralManager每扫描到一个Peripheral就会调用一次该代理
- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                  RSSI:(NSNumber *)RSSI
{
    NSLog(@"发现设备 DEV:%@ RSSI:%@", peripheral.name, RSSI);
    
    if ([peripheral.name isEqualToString:@"aLock-1EFC365FF7503"])
    {
        self.peripheral = peripheral;
        [self.centralManager stopScan];//停止扫描 节省电量 资源占用
        NSLog(@">>>已找到设备，停止扫描");
    }
    
}

#pragma mark - 连接设备成功后的代理
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"——————————————————————————————————连接成功！——————————————————————————————————————————");
    NSLog(@"设备名称是: %@", peripheral.name);
    
    //当你开始与peripheral交互之前，你需要设置好peripheral的delegate，确保能收到相应的回调
    peripheral.delegate = self;
    
#pragma mark - 发现设备上的全部Service 也可以指定某个特定的Service
    [peripheral discoverServices:nil];//-->#pragma mark - 外设发现服务的时候的代理
    
    /*
     注意：在真实的app中，你可能不会传nil作为参数，因为这样做会返回peripheral设备上的所有可用service，
     因为一个peripheral可能包含的service比你感兴趣的多得多，发现它们全部是对电量和时间的浪费。你更有可能会指定已知感兴趣的service的UUID
     
     当指定的service被发现时，peripheral（即你连接到的那个CBPeripheral对象）会调用它的delegate对象上的peripheral:didDiscoverServices:方法。
     Core Bluetooth创建一个CBService对象数组，一一对应peripheral上发现的service。
     如下所示，你可以实现这个delegate方法以访问这个发现到的service的数组。
     
     - (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
     
     
     */
    
}

#pragma mark - 外设发现服务的时候的代理
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    int count = 1;
    
    [self.mArrService removeAllObjects];//清空数组
    NSLog(@"——————————————————————————————————发现外围设备的Service——————————————————————————————————————————");
    for (CBService *service in peripheral.services)
    {
        NSLog(@"Service %d  %@", count, service);
        ++count;
        [self.mArrService addObject:service];
        
    }
    
}

//懒加载
- (NSMutableArray *)mArrService
{
    if (_mArrService == nil)
    {
        _mArrService = [[NSMutableArray alloc] init];
    }
    return _mArrService;
    
}

- (NSMutableArray *)mArrCharacteristic
{
    if (_mArrCharacteristic == nil)
    {
        _mArrCharacteristic = [[NSMutableArray alloc] init];
    }
    return _mArrCharacteristic;
    
}

/*当characteristic被发现时，peripheral会调用delegate对象的peripheral:didDiscoverCharacteristicsForService:error:方法。
 Core Bluetooth会创建一个 CBCharacteristic对象的数组，对应每个发现的characteristic*/
#pragma mark 发现服务中的特征值后的回调
- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverCharacteristicsForService:(CBService *)service
             error:(NSError *)error
{
    int count = 1;
    [self.mArrCharacteristic removeAllObjects];
    NSLog(@"——————————————————————————————————发现外围设备服务的Characteristics——————————————————————————————————————————");
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"%d %@", count, characteristic);
        count++;
        [self.mArrCharacteristic addObject:characteristic];
    }
    
}

/*
 当你read 这个特征的时候也会调用该代理
 当你成功订阅了某个characteristic值，这个值变化时peripheral设备会通知你。每当这个值发生变化,会调用该代理
 */
#pragma mark 读取Characteristic的值时的回调
- (void)peripheral:(CBPeripheral *)peripheral
didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error
{
    if (error != nil)
    {
        /*
         注意：不是所有characteristic都保证有一个可读的值，你可以通过访问CBCharacteristicPropertyRead常量判定这个characteristic值是否可读，
         详见CBCharacteristic Class Reference。若你试图读取一个不可读的值，
         peripheral:didUpdateValueForCharacteristic:error:delegate方法会返回一个对应的error。
         */
        NSLog(@"当前 Characteristic 不可读: error %@",error);
    }
    else
    {
        NSData *data = characteristic.value;
        NSLog(@"当前 Characteristic 的 value :%@", data);
    }
    
}

/*
 当你尝试订阅或取消订阅一个characteristic值时，peripheral会调用delegate对象的peripheral:didUpdateNotificationStateForCharacteristic:error:方法。
 若订阅请求出现任何问题，你可以通过实现这个delegate方法拿到错误原因
 */
#pragma mark 订阅特征值之后 特征值发生变化时的回调
- (void)peripheral:(CBPeripheral *)peripheral
didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error
{
    if (error)
    {
        NSLog(@"当前特征值不支持订阅 Error:%@", [error localizedDescription]);
    }
    else
    {
        NSLog(@"didUpdateNotificationStateForCharacteristic:特征值发生变化:%@", characteristic);
    }
    
}

/*
 当你试图写入characteristic值时，你要指定你想执行什么类型的写入。在上面的例子中，写入类型指定为CBCharacteristicWriteWithResponse，这表示peripheral会告知你的app写入是否成功。有关Core Bluetooth framework支持哪些写入类型的更多信息，参见 CBPeripheral Class Reference类的CBCharacteristicWriteType枚举。
 peripheral会响应那些指定为CBCharacteristicWriteWithResponse类型的写入请求，通过调用delegate对象的peripheral:didWriteValueForCharacteristic:error:
 方法。如果写入有任何问题，你可以实现这个delegate方法拿到错误原因，如下例所示
 */
#pragma mark - 写入特征值后的回调 [如果设备会相应的话]
- (void)peripheral:(CBPeripheral *)peripheral
didWriteValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error
{
    if (error)
    {
        NSLog(@"Error writing characteristic value: %@", [error localizedDescription]);
    }
    else
    {
        NSLog(@"写入特征值后的回到信息,peripheral:%@,characteristic:%@", peripheral, characteristic);
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
