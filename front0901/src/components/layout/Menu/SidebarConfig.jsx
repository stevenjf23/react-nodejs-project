import React from 'react'
import { PersonOutlined, HomeOutlined, ShoppingCartOutlined, Inventory2Outlined, DirectionsCarOutlined, LocalCarWashOutlined, RvHookupOutlined, DriveEtaOutlined, CarRepairOutlined, CommuteOutlined, CleaningServicesOutlined, SanitizerOutlined, SoapOutlined, PeopleOutlined, AddShoppingCartOutlined, BusinessOutlined, ContactPhoneOutlined } from '@mui/icons-material' // Importa los nuevos iconos

const sidebarConfig = [
	{
		title: 'inicio',
		path: '/app',
		icon: <DirectionsCarOutlined />
	},
	{
		title: 'usuarios',
		path: '/app/usuarios',
		icon: <PeopleOutlined />
	},

	{
		title: 'Proveedores Productos',
		path: '/app/proveedores',
		icon: <BusinessOutlined /> // Cambiado a un icono de inventario
	},





	{
		title: 'Proveedores Vehiculos',
		path: '/app/proimpo',
		icon: <ContactPhoneOutlined /> // Cambiado a un icono de inventario
	},





	{
		title: 'Compras Productos',
		path: '/app/productos',
		icon: <CleaningServicesOutlined /> // Cambiado a un icono de compras
	},
	{
		title: 'Inventario Car Wash',
		path: '/app/inventario',
		icon: <SanitizerOutlined /> // Cambiado a un icono de inventario
	},
	{
		title: 'Compras Vehiculos',
		path: '/app/vehiculos',
		icon: <AddShoppingCartOutlined /> // Cambiado a un icono de inventario
	},
	{
		title: 'Inventario Vehiculos',
		path: '/app/predios',
		icon: <CommuteOutlined /> // Cambiado a un icono de inventario
	}
	

	




]

export default sidebarConfig
