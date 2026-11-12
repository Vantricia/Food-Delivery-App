import React from 'react';
import './table.css';
import Dropdown from '../Dropdown/dropdown';
import PropTypes from 'prop-types';

const Table = ({ orders, handleDelete }) => {
  const handleSelect = (option) => {
    console.log('Selected option:', option);
  };

  // Sort orders by date in descending order
  const sortedOrders = Array.isArray(orders)
    ? [...orders].sort((a, b) => {
        const dateA = new Date(a.date);
        const dateB = new Date(b.date);
        console.log(`Comparing dates: ${dateA} and ${dateB}`);
        return dateB - dateA;
      })
    : [];

  console.log('Sorted orders:', sortedOrders);

  return (
    <div className="contain-table">
      <table className="striped-table">
        <thead>
          <tr>
            <th>Date</th>
            <th>Email</th>
            <th>Location</th>
            <th>Total Item</th>
            <th>Total Price</th>
            <th>Receipt</th>
            <th className="dropdown-column">Driver</th>
            <th className="text-center">Actions</th>
          </tr>
        </thead>
        <tbody>
          {sortedOrders.length > 0 ? (
            sortedOrders.map((order, i) => (
              <tr key={i}>
                <td>{order.date}</td>
                <td>{order.email}</td>
                <td>{order.location}</td>
                <td>{order.totalItem}</td>
                <td>{order.total}</td>
                <td>{order.order}</td>
                <td className="dropdown-cell">
                  <Dropdown orderId={order.id} onSelect={handleSelect} />
                </td>
                <td className="text-left">
                  <button
                    onClick={() => handleDelete(order.id)}
                    className="button muted-button"
                  >
                    Delete
                  </button>
                </td>
              </tr>
            ))
          ) : (
            <tr>
              <td colSpan={8}>No orders available</td>
            </tr>
          )}
        </tbody>
      </table>
    </div>
  );
};

Table.propTypes = {
  orders: PropTypes.arrayOf(PropTypes.object).isRequired,
  handleDelete: PropTypes.func.isRequired,
};

export default Table;
