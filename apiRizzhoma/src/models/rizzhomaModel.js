const pool = require('../config/database');
const bcrypt=require('bcrypt');
const {v4:uuidv4}=require('uuid');

class rizzhomaModel{
    static async createUser(username, email, password, callback) {
        try {
          const salt = await bcrypt.genSalt(9);
          const hashedPassword = await bcrypt.hash(password, salt);
      
          const query = 'INSERT INTO appuser (username, email, password) VALUES (?, ?, ?)';
          const values = [username, email, hashedPassword];
      
          pool.query(query, values, (error, results) => {
            if (typeof callback === 'function') {
              if (error) {
                return callback(error, null);
              }
              callback(null, results);
            } else {
              console.error("Callback is not a function:", callback);
            }
          });
        } catch (error) {
          if (typeof callback === 'function') {
            callback(error, null);
          } else {
            console.error("Callback is not a function:", callback);
          }
        }
      }
    
      static ambilSemuaUser(callback) {
        const query = 'SELECT * FROM appuser';
      
        pool.query(query, (error, results) => {
          if (typeof callback === 'function') {
            if (error) {
              return callback(error, null);
            }
            callback(null, results);
          } else {
            console.error("Callback is not a function:", callback);
          }
        });
      }

      static ambilUserByEmail(email, callback) {
        const query = 'SELECT * FROM appuser WHERE email=?';
        const values = [email];
        console.log("Searching for email:", email);
    
        pool.query(query, values, (error, results) => {
          if (typeof callback === 'function') {
            if (error) {
              return callback(error, null);
            }
            callback(null, results);
          } else {
            console.error("Callback is not a function:", callback);
          }
        });
      }

      static async logIn(email, password) {
        const query = 'SELECT * FROM appuser WHERE email=?';
        const values = [email];
    
        return new Promise((resolve, reject) => {
            pool.query(query, values, async (error, results) => {
                if (error) {
                    return reject(error); // Handle database error
                }
    
                if (results.length === 0) {
                    return resolve(false); // No user found
                }
    
                const user = results[0]; // Get the first result
                const isPasswordValid = await bcrypt.compare(password, user.password); // Compare passwords
    
                if (!isPasswordValid) {
                    return resolve(false); // Password doesn't match
                }
    
                resolve(user); // User verified
            });
        });
      }

      static ambilUserById(userID, callback) {
        const query = 'SELECT * FROM appuser WHERE userID = ?';
        const values = [userID];
    
        pool.query(query, values, (error, results) => {
          if (typeof callback === 'function') {
            if (error) {
              return callback(error, null);
            }
            callback(null, results);
          } else {
            console.error("Callback is not a function:", callback);
          }
        });
      }

      static transaction(userID, totalAmount){
        const query = 'INSERT INTO transaction (userID, totalAmount) VALUES (?, ?)';
        const values = [userID, totalAmount];
    
        pool.query(query, values, (error, results) => {
          if (typeof callback === 'function') {
            if (error) {
              return callback(error, null);
            }
            callback(null, results);
          } else {
            console.error("Callback is not a function:", callback);
          }
        });
      }

      static ambilDonasi(callback) {
        const query = "SELECT * FROM donation;";
        pool.query(query,(error, results) => {
            if (error) {
                return callback(error, null);
            }
            callback(null, results);
        });
      }

      static ambilDonasiById(donationID, callback) {
        const query = 'SELECT * FROM donation WHERE donationID = ?';
        const values = [donationID];
    
        pool.query(query, values, (error, results) => {
          if (typeof callback === 'function') {
            if (error) {
              return callback(error, null);
            }
            callback(null, results);
          } else {
            console.error("Callback is not a function:", callback);
          }
        });
      }

      //Temporary
      static ambilSemuaPohon(callback) {
        const query = 'SELECT * FROM pohon';

        pool.query(query, (error, results) => {
            if (typeof callback === 'function') {
                if (error) {
                    return callback(error, null);
                }
                callback(null, results);
            } else {
                console.error("Callback is not a function:", callback);
            }
        });
      }
}

module.exports = rizzhomaModel;